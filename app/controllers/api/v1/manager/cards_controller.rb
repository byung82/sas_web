module Api
  module V1
    module Manager
      class CardsController < Api::ApplicationController
        def index
          item = Api::V1::Manager::Card::Request.create(params)

          raise ActiveRecord::RecordInvalid, item if !item.valid?

          response = Api::V1::Manager::Card::Response.search(item)

          render json: response, serializer: Api::V1::Manager::CardsSerializer

        rescue => e
          process_exception(e)
        end

        def show
          item = ::Store.find_by(id:  params[:id])

          render json: {
              item: item
          }
        end
      end
    end
  end
end

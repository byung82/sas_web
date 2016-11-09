module Api
  module V1
    module Manager
      class UsagesController < Api::ApplicationController
        def index
          item = Api::V1::Manager::Usage::Request.create(params)

          raise ActiveRecord::RecordInvalid, item if !item.valid?

          response = Api::V1::Manager::Usage::Response.search(item)

          render json: response, serializer: Api::V1::Manager::UsagesSerializer

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

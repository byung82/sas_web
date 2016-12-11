module Api
  module V1
    module Manager
      class ChargesController < Api::ApplicationController

        protect_from_forgery with: :null_session

        def index
          item = Api::V1::Manager::Charge::Request.create(params)

          raise ActiveRecord::RecordInvalid, item if !item.valid?

          response = Api::V1::Manager::Charge::Response.search(item)

          render json: response, serializer: Api::V1::Manager::ChargesSerializer

        rescue => e
          process_exception(e)
        end
      end
    end
  end
end

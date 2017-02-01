module Api
  module V1
    class UsagesController < Api::ApplicationController

      protect_from_forgery with: :null_session

      def index

        item = Api::V1::Request::Usage.create(params)

        raise ActiveRecord::RecordInvalid, item if !item.valid?

        response = Api::V1::Response::Usage.search(item)

        render json: response, serializer: Api::V1::Www::Usages::Index::UsagesSerializer

      # rescue => e
      #   process_exception(e)
      end
    end
  end
end

module Api
  module V1
    module Manager
      module Charge
        class Response
          include ActiveModel::Validations
          include ActiveModel::Conversion
          include ActionView::Helpers::NumberHelper
          include ActiveModel::Serialization
          extend ActiveModel::Naming

          attr_accessor :total_count, :total_page, :data, :page

          def initialize(attributes = {})
            attributes.each do |name, value|
              send("#{name}=", value)
            end
          end

          def self.search(request)


            items = ::LimitRequest.where(store_id: request.store_id).where('save_amt > 0')

            items = items.page(request.page).order('id desc').per(15)

            response = Response.new

            response.total_count = items.total_count
            response.total_page = items.total_count / 15
            response.page = request.page
            response.data = items

            response
          end
        end
      end
    end
  end
end

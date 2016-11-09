module Api
  module V1
    module Manager
      module Store
        class Request
          include ActiveModel::Validations
          include ActiveModel::Conversion
          include ActionView::Helpers::NumberHelper
          extend ActiveModel::Naming

          attr_accessor :page, :keyword

          # validates_presence_of :business_no, :card_no, :phone_no
          #
          # validate :check_business_no, :check_card_no

          def initialize(attributes = {})
            attributes.each do |name, value|
              send("#{name}=", value)
            end
          end



          def self.create(params)

            page = params[:page] || 1

            Rails.logger.debug "PAGE : #{page}"

            item = Request.new
            item.page = page
            item.keyword = params[:keyword]
            item
          end
        end
      end

    end
  end
end

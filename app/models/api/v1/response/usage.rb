module Api
  module V1
    module Response
      class Usage
        include ActiveModel::Validations
        include ActiveModel::Conversion
        include ActionView::Helpers::NumberHelper
        include ActiveModel::Serialization
        extend ActiveModel::Naming

        attr_accessor :success, :total_count, :items

        def initialize(attributes = {})
          attributes.each do |name, value|
            send("#{name}=", value)
          end
        end

        def self.search(usage, page)
          items = StoreLimitDet.where(business_no: usage.business_no)
              .where(user_seq: usage.user_seq)
              .where(status_cd: %w(LS002 LS003))
              # .page(1)
          #.page usage.page

          items = items.page(page)

          usage = Usage.new
          usage.success = true
          usage.total_count = items.total_count
          usage.items = items

          usage
        end
      end
    end
  end
end

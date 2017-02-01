module Api
  module V1
    module Response
      class Usage
        include ActiveModel::Validations
        include ActiveModel::Conversion
        include ActionView::Helpers::NumberHelper
        include ActiveModel::Serialization
        extend ActiveModel::Naming

        attr_accessor :success, :total_count, :items, :page

        def initialize(attributes = {})
          attributes.each do |name, value|
            send("#{name}=", value)
          end
        end

        def self.search(item)
          items = StoreLimitDet.where(business_no: item.business_no)
              .where(user_seq: item.user_seq)
              .where(status_cd: %w(LS002 LS003))
              # .page(1)
          #.page usage.page

          items = items.page(item.page)

          usage = Usage.new
          usage.success = true
          usage.total_count = items.total_count
          usage.page = item.page
          usage.items = items

          usage
        end
      end
    end
  end
end

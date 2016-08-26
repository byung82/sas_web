module Api
  module V1
    module Response
      class Card
        include ActiveModel::Validations
        include ActiveModel::Conversion
        include ActionView::Helpers::NumberHelper
        extend ActiveModel::Naming

        attr_accessor :success, :business_no, :card_no, :amt

        def initialize(attributes = {})
          attributes.each do |name, value|
            send("#{name}=", value)
          end
        end

        def self.create(item)
          charge = Card.new

          charge.success = true
          charge.business_no = item.store.business_no
          charge.amt = item.limit_amt

          charge
        end
      end
    end
  end
end

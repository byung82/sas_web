module Api
  module V1
    module Response
      class Charge
        include ActiveModel::Validations
        include ActiveModel::Conversion
        include ActionView::Helpers::NumberHelper
        extend ActiveModel::Naming

        attr_accessor :success, :tid, :card_limit, :amt

        def initialize(attributes = {})
          attributes.each do |name, value|
            send("#{name}=", value)
          end
        end

        def self.create(item)
          charge = Charge.new

          charge.success = true
          charge.card_limit = item.store_card.limit_amt + item.amt
          charge.amt = item.amt
          charge.tid = item.id
          charge.user_seq = item.store_card.user_seq

          charge
        end
      end
    end
  end
end

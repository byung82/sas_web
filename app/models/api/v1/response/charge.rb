module Api
  module V1
    module Response
      class Charge
        include ActiveModel::Validations
        include ActiveModel::Conversion
        include ActionView::Helpers::NumberHelper
        extend ActiveModel::Naming

        attr_accessor :success, :tid, :card_limit, :amt, :seq_no

        def initialize(attributes = {})
          attributes.each do |name, value|
            send("#{name}=", value)
          end
        end

        def self.create(item)
          charge = Charge.new

          charge.success = true
          charge.card_limit = item.amt
          charge.amt = item.amt - item.store_card.limit_amt
          charge.tid = item.id
          charge.seq_no = item.seq_no

          charge
        end
      end
    end
  end
end

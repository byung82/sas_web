module Api
  module V1
    module Request
      class Charge
        include ActiveModel::Validations
        include ActiveModel::Conversion
        include ActionView::Helpers::NumberHelper
        extend ActiveModel::Naming

        attr_accessor :business_no, :card_no, :amt

        validates_presence_of :business_no, :card_no, :amt,

        validate :check_business_no, :check_card_no

        def initialize(attributes = {})
          attributes.each do |name, value|
            send("#{name}=", value)
          end
        end


        def check_business_no
          errors.add(:business_no, '사업자번호가 존재하지 않습니다') if Store.where(business_no: self.business_no).count <= 0
        end

        def check_card_no
          errors.add(:card_no, '카드반호가 존재하지 않습니다') if Store.where(card_no: self.card_no).count <= 0
        end

      end
    end
  end
end

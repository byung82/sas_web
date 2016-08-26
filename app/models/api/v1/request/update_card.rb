module Api
  module V1
    module Request
      class UpdateCard
        include ActiveModel::Validations
        include ActiveModel::Conversion
        include ActionView::Helpers::NumberHelper
        extend ActiveModel::Naming

        attr_accessor :business_no, :card_no, :phone_no

        validates_presence_of :business_no, :card_no, :phone_no, :user_seq

        validate :check_business_no, :check_card_no, :user_seq

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


        def self.create(params)

          items = params[:id].split(/,/)

          item = UpdateCard.new
          item.business_no = items[0]
          item.card_no = items[1]
          item.phone_no = params[:phone_no]
          item.user_seq = params[:user_seq]
          item
        end
      end
    end
  end
end

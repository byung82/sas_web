module Api
  module V1
    module Request
      class Usage
        include ActiveModel::Validations
        include ActiveModel::Conversion
        include ActionView::Helpers::NumberHelper
        extend ActiveModel::Naming

        attr_accessor :business_no, :user_seq, :page

        validates_presence_of :business_no, :user_seq

        validate :check_business_no, :check_user_seq


        def initialize(attributes = {})
          attributes.each do |name, value|
            send("#{name}=", value)
          end
        end

        def check_business_no
          errors.add(:business_no, '사업자번호가 존재하지 않습니다') if Store.where(business_no: self.business_no).count <= 0
        end

        def check_card_no
          store_card = StoreCard.find_by(user_seq: self.card_no, business_no: self.business_no)
          errors.add(:user_seq, '사용자 등록이 되어 있지 않습니다') if !store_card.present?
        end


        def self.create(params)

          items = params[:id].split(/,/)

          item = Usage.new
          item.business_no = items[0]
          item.user_seq = items[1]
          item.page = params[:page] || 1
          item
        end
      end
    end
  end
end

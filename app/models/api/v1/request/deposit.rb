module Api
  module V1
    module Request
      class Deposit
        include ActiveModel::Validations
        include ActiveModel::Conversion
        include ActionView::Helpers::NumberHelper
        extend ActiveModel::Naming

        attr_accessor :business_no, :tid

        validates_presence_of :business_no, :tid

        validate :check_business_no, :check_card_no

        def initialize(attributes = {})
          attributes.each do |name, value|
            send("#{name}=", value)
          end
        end

        def check_business_no
          errors.add(:business_no, '사업자번호가 존재하지 않습니다') if Store.where(business_no: self.business_no).count <= 0
        end

        def self.create(params)
          item = Deposit.new
          item.business_no = params[:business_no]
          item.tid = params[:tid]
          item
        end
      end
    end
  end
end

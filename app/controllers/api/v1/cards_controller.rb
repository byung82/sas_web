module Api
  module V1
    class CardsController < Api::ApplicationController

      def show

        item = Api::V1::Request::Card.create(params, false)

        raise ActiveRecord::RecordInvalid, item if !item.valid?

        raise StandardError, '긴급 점검중입니다 잠시후에 진행해주세요'

        @item = StoreCard.find_by(card_no: item.card_no)

        render json: {
            success: true,
            amt: @item.limit_amt,
            card_no: @item.card_no,
            business_no: @item.store.business_no
        }

      rescue => e
        process_exception(e)
      end

      def update
        item = Api::V1::Request::UpdateCard.create params

        raise StandardError, '긴급 점검중입니다 잠시후에 진행해주세요'

        raise ActiveRecord::RecordInvalid, item if !item.valid?

        @item = StoreCard.find_by(card_no: item.card_no)

        StoreCard.transaction do
          @item.phone_no = item.phone_no
          @item.user_seq = item.user_seq
          @item.save
        end

        render json: {
            success: true
        }

      rescue => e
        process_exception(e)
      end
    end
  end
end

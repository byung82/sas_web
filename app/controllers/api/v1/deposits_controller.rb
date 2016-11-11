module Api
  module V1
    class DepositsController < Api::ApplicationController

      protect_from_forgery with: :null_session

      def create

        item = Api::V1::Request::Deposit.create(params)
        raise ActiveRecord::RecordInvalid, item if !item.valid?

        @item = LimitRequest.find_by(id: item.tid)

        raise StandardError, '해당하는 카드충전내역이 없습니다' if !@item.present?

        render json: {
            success: true,
            message: ''
        }

      rescue => e
        process_exception(e)
      end
    end
  end
end

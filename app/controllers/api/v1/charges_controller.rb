module Api
  module V1
    class ChargesController < Api::ApplicationController

      protect_from_forgery with: :null_session

      def create

        item = Api::V1::Request::Charge.new
        item.business_no = params[:business_no]
        item.card_no = params[:card_no]
        item.amt = params[:amt]


        raise ActiveRecord::RecordInvalid, item if !item.valid?

        store = current_user.stores.find_by(business_no: item.business_no)

        store_card = store.store_cards.find_by(card_no: item.card_no)

        LimitRequest.transaction do

          @item = LimitRequest.create!(
                                  card_no: item.card_no,
                                  business_no: item.business_no,
                                  amt: store_card.sync_amt + item.amt.to_i,
                                  limit_cd: 'CL001',
                                  store: store,
                                  store_card: store_card,
                                  created: current_user,
                                  updated: current_user
          )
        end

        render json: @item.response

      rescue => e
        process_exception(e)
      end
    end
  end
end

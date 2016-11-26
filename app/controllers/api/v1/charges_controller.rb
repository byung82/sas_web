module Api
  module V1
    class ChargesController < Api::ApplicationController

      protect_from_forgery with: :null_session

      def create

        item = Api::V1::Request::Charge.new
        item.business_no = params[:business_no]
        item.card_no = params[:card_no]
        item.amt = params[:amt]
        item.seq_no = params[:seq_no]

        raise ActiveRecord::RecordInvalid, item if !item.valid?

        #store = current_user.stores.find_by(business_no: item.business_no)

        store_card = StoreCard.find_by(card_no: item.card_no)

        store = store_card.store

        #store_card = store.store_cards.find_by(card_no: item.card_no)

        LimitRequest.transaction do

          @item = LimitRequest.find_or_initialize_by(business_no: store_card.business_no,
                                                     seq_no: item.seq_no)
          if @item.new_record?
            @item.card_no = item.card_no
            @item.amt = (store_card.sync_amt||0) + item.amt.to_i
            @item.save_amt = item.amt.to_i
            @item.type_cd = 'CT004'
            @item.limit_cd = 'CL001'
            @item.store = store
            @item.deposit_yn = false
            @item.store_card = store_card
            @item.created = current_user
            @item.updated = current_user

            @item.save!
          end
        end

        render json: @item.response

      rescue => e
        process_exception(e)
      end
    end
  end
end

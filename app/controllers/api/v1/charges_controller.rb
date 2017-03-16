module Api
  module V1
    class ChargesController < Api::ApplicationController

      protect_from_forgery with: :null_session

      def get_sync_amt(card_no)

        begin
          now = Time.local.now

          limit = Sas::Packet::LimitCard.new
          limit.hdr_c = '0000'
          limit.tsk_dv_c = '3000'
          limit.etxt_snrc_sn = SecureRandom.random_number(9999999999).
              to_s.rjust(10, '0')
          limit.trs_dt = now.strftime('%Y%m%d')
          limit.trs_t = now.strftime('%H%M%S')
          limit.rsp_c = '0000'
          limit.card_no = card_no
          len = limit.to_binary_s.length

          limit.hdr_c = (len - 4).to_s.rjust(4, '0')

          sock = TCPSocket.open('sas-card', 19703)

          sock.puts limit.to_binary_s

          buffer = sock.recv(len + 4)

          limit = Sas::Packet::LimitCard.read(buffer)

          logger.debug "LIMIT: #{limit}"

          limit.card_amt
        rescue => e
          logger.fatal "e: #{e}"
          nil
        end
      end

      def create

        item = Api::V1::Request::Charge.new
        item.business_no = params[:business_no]
        item.card_no = params[:card_no]
        item.amt = params[:amt]
        item.seq_no = params[:seq_no]

        raise ActiveRecord::RecordInvalid, item if !item.valid?

        hour = Time.now.localtime.hour

        if hour == 20
          raise StandardError, "오후 8시부터 오후 9시는 정기점검 시간입니다\n 오후 9시 이후에 충전 요청을 해주시기 바랍니다"
        end

        #store = current_user.stores.find_by(business_no: item.business_no)

        store_card = StoreCard.find_by(card_no: item.card_no)

        store = store_card.store

        #store_card = store.store_cards.find_by(card_no: item.card_no)

        LimitRequest.transaction do

          @item = LimitRequest.find_or_initialize_by(business_no: store_card.business_no,
                                                     seq_no: item.seq_no)

          sync_amt = get_sync_amt(item.card_no)

          sync_amt = (store_card.sync_amt||0) if sync_amt == nil

          if @item.new_record?
            @item.card_no = item.card_no
            @item.amt = sync_amt + item.amt.to_i
            @item.save_amt = item.amt.to_i
            @item.type_cd = 'CT004'
            @item.limit_cd = 'CL001'
            @item.store = store

            if current_user.login != 'humoney'
              @item.deposit_yn = false
            else
              @item.deposit_yn = true
            end

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

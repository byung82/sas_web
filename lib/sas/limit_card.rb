
module Sas

  class LimitCard < EventMachine::Connection

    def initialize

      @queue = Hash.new


      @redis = EM::Hiredis.connect

      pubsub = @redis.pubsub
      pubsub.subscribe 'CARD_SYNC.SEND'
      pubsub.subscribe 'CARD_SYNC.RECV'

      pubsub.on(:message) do |channel, message|

        p "#{channel}, #{message}"

        if channel == 'CARD_SYNC.SEND'
          #         message = JSON.parse(message, symbolize_names: true)

          limit = @queue[message]
          send_data limit.to_binary_s
        end
      end

    end

    def unbind
      Rails.logger.debug '접속해제'
      EventMachine.stop
    end

    def post_init
      # Rails.logger.debug '카드 한도 조회 새로운접속'
      # p '카드 한도 조회 새로운접속'

      hour = Time.now.localtime.hour

      Rails.logger.debug "카드 한도 조회 새로운접속 : #{hour}시간"
      p "카드 한도 조회 새로운접속 : #{hour}시간"

      if hour < 20 && hour > 9
        return
      end

      is_first = false

      sql = <<-SQL
SELECT
    ID,
    CARD_NO,
    ROW_NUMBER() OVER (PARTITION BY CARD_NO ORDER BY CARD_NO) ORDER_NO
FROM STORE_CARDS
WHERE LIMIT_AMT - SYNC_AMT != 0
      SQL

      cards = LimitRequest.connection.select_all(sql)

      cards.each do |item|

        card_no = item['card_no']

        now = Time.now.localtime

        limit = Sas::Packet::LimitCard.new
        limit.hdr_c = '0000'
        limit.tsk_dv_c = '3000'
        limit.etxt_snrc_sn = SecureRandom.random_number(9999999999).to_s.rjust(10, '0')
        limit.trs_dt = now.strftime('%Y%m%d')
        limit.trs_t = now.strftime('%H%M%S')
        limit.rsp_c = '0000'
        limit.card_no = card_no

        len = limit.to_binary_s.length
        limit.hdr_c = (len-4).to_s.rjust(4, '0')

        @queue[card_no] = limit



        LimitCardLog.create(
            type_cd: 'P001',
            hdr_c: limit.hdr_c,
            tsk_dv_c: limit.tsk_dv_c,
            etxt_snrc_sn: limit.etxt_snrc_sn,
            trs_dt: limit.trs_dt,
            trs_t: limit.trs_t,
            rsp_c: limit.rsp_c,
            card_no: limit.card_no,
            amt: limit.amt
        )

        #
        #   LimitLog.create(
        #       type_cd: 'P001',
        #       hdr_c: limit.hdr_c,
        #       tsk_dv_c: limit.tsk_dv_c,
        #       etxt_snrc_sn: limit.etxt_snrc_sn,
        #       trs_dt: limit.trs_dt,
        #       trs_t: limit.trs_t,
        #       rsp_c: limit.rsp_c,
        #       bzr_no: limit.bzr_no,
        #       dlng_dv_c: "#{limit.dlng_dv_c}000",
        #       crtl_pge_no: limit.crtl_pge_no,
        #       wo_pge_n: limit.wo_pge_n,
        #       card: cards.to_json
        #   )
        # end

        if is_first == false
          is_first = true

          EM.add_timer(2) {
            @redis.publish('CARD_SYNC.SEND', card_no)
          }
        end
      end
    end

    def receive_data(data)

      @buffer ||= []
      @data_size ||= 0
      @current_size ||= 0

      if @buffer.empty?
        # First four characters of any framed message will always be the size of message
        @len =  BinData::String.new(:length => 4)
        @data_size = @len.read(data).to_s.to_i + 4
        data = data[0..-1]
      end

      take_data_size = @data_size - @current_size
      fragment = data[0..take_data_size]
      @buffer << fragment
      @current_size += fragment.length

      Rails.logger.debug "CURRENT_SIZE: #{@current_size}"


      if @current_size == @data_size
        begin
          process_message(@buffer.join)
        rescue => e
          Rails.logger.warn "데이터수신 오류 : #{e}, #{e.backtrace}"

          close_connection_after_writing
            # make sure you catch your exceptions here or your server will explode!
        ensure
          # if you're catching exceptions, make sure you always clear your buffer in the end
          # otherwise it'll mess with your next framed messaging processing
          @buffer.clear
          @current_size = 0
          @data_size = 0

          # In the case where we received the next framed message,
          # recursively call receive_data to process it
          receive_data(data[(take_data_size + 1)..-1]) if data.length > take_data_size
        end
      end

      # while true
      #   header = Header.read(data)
      #
      #   Rails.logger.debug "HEADER : #{header}"
      #
      #   if header.tsk_dv_c == '1000'
      #
      #   elsif header.tsk_dv_c == '2001'
      #   end
      # end
    end

    def process_message(buffer)

      limit = Sas::Packet::LimitCard.read(buffer)

      Rails.logger.debug "process_message : #{limit}"

      # page_no = limit.crtl_pge_no.to_s.to_i
      #
      # cards = []
      #
      # limit.items.each do |cc|
      #   aa = { :card_no => cc.card_no.to_s, amt: cc.lim_am.to_i }
      #   cards << aa
      # end
      #
      LimitCardLog.create(
          type_cd: 'P002',
          hdr_c: limit.hdr_c,
          tsk_dv_c: limit.tsk_dv_c,
          etxt_snrc_sn: limit.etxt_snrc_sn,
          trs_dt: limit.trs_dt,
          trs_t: limit.trs_t,
          rsp_c: limit.rsp_c,
          card_no: limit.card_no,
          amt: limit.amt
      )

      @queue.delete limit.card_no

      Rails.logger.debug "QUEUE DELETE #{limit.card_no}, #{@queue.length}"
      p "QUEUE DELETE #{limit.card_no}, #{@queue.length}"

      if @queue.length == 0

        Rails.logger.debug '전송완료'
        close_connection_after_writing
      else
        item = @queue.keys.first
        Rails.logger.debug "CARD_SYNC.SEND : #{item}"

        @redis.publish('CARD_SYNC.SEND', item)
      end
    end

    def self.startup

      # $redis = EM::Hiredis.connect

      $stdout.sync = true

      Rails.logger = Logger.new("#{Rails.root}/log/limit_card_#{Rails.env}.log")


      EventMachine::run {
        EventMachine::connect 'sas-card', 19703, LimitCard
      }
    end
  end

end

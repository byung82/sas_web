
module Limit

  class LimitCard < EventMachine::Connection

    def initialize

      @queue = Hash.new


      # (1..10).each do |item|
      #   @redis.publish('SAS.RECV', item)
      #   p "ITEM : #{item}"
      # end

      @redis = EM::Hiredis.connect
      #
      # p "#{@redis}"
      # # send_sub = @redis.pubsub
      # # recv_sub = @redis.pubsub
      #
      pubsub = @redis.pubsub
      #
      # p "#{pubsub}"
      #
      pubsub.subscribe 'CARD_SYNC.SEND'
      pubsub.subscribe 'CARD_SYNC.RECV'
      # # pubsub.subscribe 'SAS.RECV'
      #
      #
      pubsub.on(:message) do |channel, message|

        p "#{channel}, #{message}"

        if channel == 'CARD_SYNC.SEND'
          message = JSON.parse(message, symbolize_names: true)

          limit = @queue[message[:card_no]]
          # limit = queue[message[:card_no]]
          # p limit.items.to_json
          # ttt = JSON.parse(aaa)

          send_data limit.to_binary_s
        end
      end

    end

    def unbind
      Rails.logger.debug '접속해제'
      EventMachine.stop
    end

    def post_init
      Rails.logger.debug '새로운접속'

      # p "connect"

      # EM.add_timer(2) {
      #   @redis.publish('SAS.SEND', {data: 111})
      #   @redis.publish('SAS.RECV', {data: 222})
      # # }


      is_first = false

      sql = <<-SQL
SELECT
    ID,
    CARD_NO,
    ROW_NUMBER() OVER (PARTITION BY CARD_NO ORDER BY CARD_NO) ORDER_NO
FROM STORE_CARDS
WHERE LIMIT_AMT - SYNC_AMT != 0
      SQL

#       sql = <<-SQL
# SELECT
#   BUSINESS_NO
# FROM STORES
# WHERE SEND_AT IN
# (
#   SELECT
#     MIN(SEND_AT)
#   FROM STORES
#   WHERE SYNC_YN = 'Y'
# )
# AND ROWNUM=1
#       SQL

      cards = LimitRequest.connection.select_all(sql)

      cards.each do |card_no|

        # plsql.store_card_pkg.update_store_card(business_no['business_no'])

        # p "EXECUTE PLSQL : #{business_no['business_no']}"
        #
        # sql = <<-SQL
# SELECT
#   A.BUSINESS_NO, A.CARD_NO, DECODE(NVL(B.SEND_YN, 'Y'), 'Y', A.SYNC_AMT, A.SYNC_AMT + B.AMT) AMT
# FROM STORE_CARDS A, LIMIT_REQUESTS B
# WHERE A.CARD_NO = B.CARD_NO(+)
# AND A.BUSINESS_NO = '#{business_no['business_no']}'
#         SQL


        now = Time.now.localtime

        limit = Sas::Packet::LimitCard.new
        limit.hdr_c = '0000'
        limit.tsk_dv_c = '3000'
        limit.etxt_snrc_sn = SecureRandom.random_number(9999999999).to_s.rjust(10, '0')
        limit.trs_dt = now.strftime('%Y%m%d')
        limit.trs_t = now.strftime('%H%M%S')
        limit.rsp_c = '0000'
        limit.card_no = '9410852258686100'

        @queue[card_no] = limit

        # @queue[business_no['business_no']].each do |limit|
        #   # p items.to_json
        #
        #   # p "KEY : #{key}"
        #   # p aa
        #   cards = []
        #
        #   limit.items.each do |cc|
        #     card = { :card_no => cc.card_no.to_s, amt: cc.lim_am.to_i }
        #     cards << card
        #   end
        #
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
            @redis.publish('CARD_SYNC.SEND', {card_no: card_no}.to_json)
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
      # log = LimitLog.create(
      #     type_cd: 'P002',
      #     hdr_c: limit.hdr_c,
      #     tsk_dv_c: limit.tsk_dv_c,
      #     etxt_snrc_sn: limit.etxt_snrc_sn,
      #     trs_dt: limit.trs_dt,
      #     trs_t: limit.trs_t,
      #     rsp_c: limit.rsp_c,
      #     bzr_no: limit.bzr_no,
      #     dlng_dv_c: limit.dlng_dv_c,
      #     crtl_pge_no: limit.crtl_pge_no,
      #     wo_pge_n: limit.wo_pge_n,
      #     card: cards.to_json
      # )
      #
      # # @queue[limit.bzr_no].delete_at page_no-1
      #
      #
      # limit.items.each do |item|
      #   request = LimitRequest.find_by(card_no: item.card_no.to_s)
      #
      #   if !request.present?
      #     next
      #   end
      #
      #   request.send_yn = true
      #   request.limit_log_id = log.id
      #   request.error_yn = limit.rsp_c != '0000' && limit.rsp_c != '0001'
      #   request.code = limit.rsp_c
      #
      #   request.save
      # end

      # p @queue[limit.bzr_no]

      # item = @queue[limit.bzr_no][page_no + 1]
      #
      # p item

      limit_check = @queue[limit.card_no]
      # Rails.logger.debug "#{limit.bzr_no}, #{limit.rsp_c}, #{limit_check.crtl_pge_no}, #{page_no}, #{@queue[limit.bzr_no].length}" if limit_check != nil

      if limit_check != nil
        header = { :card_no => limit.card_no }

        Rails.logger.debug "CARD_SYNC.SEND : #{header}"

        # send_header = {business_no: limit.bzr_no, page_no: page_no + 1}
        @redis.publish('CARD_SYNC.SEND', header.to_json)
      else

        @queue.delete limit.card_no

        Rails.logger.debug "QUEUE DELETE #{limit.card_no}, #{@queue.length}"

        if @queue.length == 0

          Rails.logger.debug '전송완료'
          close_connection_after_writing
        else
          item = @queue.first

          header = { :card_no => item.card_no }

          Rails.logger.debug "CARD_SYNC.SEND : #{header}"

          # send_header = {business_no: limit.bzr_no, page_no: page_no + 1}
          @redis.publish('CARD_SYNC.SEND', header.to_json)
        end

      end


      # close_connection_after_writing
    end

    def self.startup

      # $redis = EM::Hiredis.connect

      $stdout.sync = true

      Rails.logger = Logger.new("#{Rails.root}/log/limit_card_#{Rails.env}.log")


      EventMachine::run {
        # begin
        # rescue
        # end
        # @redis.publish('DRIVER.MESSAGE', {data: 111})

        # (1..10).each do |item|
        #   p "ITEM : #{item}"
        # end


        EventMachine::connect 'sas-card', 19703, Client
      }
    end
  end
  # module Server
  #   def self.startup
  #     Rails.logger.debug 'STARTUP'
  #   end
  # end
  # EventMachine.run {
  #   EventMachine::start_server '0.0.0.0', 8888, ServerConnection
  # }
end
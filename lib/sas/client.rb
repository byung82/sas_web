module Sas

  class Client < EventMachine::Connection

    def initialize
      p "init"

      @queue = {}


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
      pubsub.subscribe 'SAS.SEND'
      pubsub.subscribe 'SAS.RECV'
      # # pubsub.subscribe 'SAS.RECV'
      #
      #
      pubsub.on(:message) do |channel, message|

        p "#{channel}, #{@queue[message.to_i].class.name}"

        if channel == 'SAS.SEND'
          limit = @queue[message.to_i]
          send_data limit.to_binary_s
        end
      end

    end

    def unbind
      Rails.logger.debug '새로운접속 해제'
    end

    def post_init
      p "------------"
      Rails.logger.debug '새로운접속'

      # p "connect"

      # EM.add_timer(2) {
      #   @redis.publish('SAS.SEND', {data: 111})
      #   @redis.publish('SAS.RECV', {data: 222})
      # # }



      sql = <<-SQL
SELECT
  b.BUSINESS_NO
FROM
(
  SELECT
    ID,
    ROW_NUMBER() OVER (PARTITION BY BUSINESS_NO ORDER BY BUSINESS_NO) ORDER_NO
  FROM limit_requests
  WHERE SEND_YN = 'N'
) a,
limit_requests b
WHERE a.ORDER_NO = 1
AND a.ID = b.ID
      SQL


      business_nos = LimitRequest.connection.select_all(sql)

      business_nos.each do |business_no|

        sql = <<-SQL
SELECT
  A.BUSINESS_NO, A.CARD_NO, DECODE(NVL(B.SEND_YN, 'Y'), 'Y', A.LIMIT_AMT, A.LIMIT_AMT + B.AMT) AMT
FROM STORE_CARDS A, LIMIT_REQUESTS B
WHERE A.CARD_NO = B.CARD_NO(+)
AND A.BUSINESS_NO = '#{business_no['business_no']}'
        SQL

        items = LimitRequest.connection.select_all(sql)

        max_page = (items.count.to_f / 250).ceil


        page_no = 1

        items.each_slice(250) do |requests|

          now = Time.now.localtime

          limit = Packet::Limit.new
          limit.hdr_c = '0000'
          limit.tsk_dv_c = '2000'
          limit.etxt_snrc_sn = SecureRandom.random_number(9999999999).to_s.rjust(10, '0')
          limit.trs_dt = now.strftime('%Y%m%d')
          limit.trs_t = now.strftime('%H%M%S')
          limit.rsp_c = '    '
          limit.bzr_no = business_no['business_no']

          limit.dlng_dv_c = 'U'
          limit.crtl_pge_no = max_page.to_s.rjust(3,'0')
          limit.wo_pge_n = page_no.to_s.rjust(3,'0')

          requests.each_with_index do |item, index|
            limit.items[index].card_no = item['card_no'].to_s.rjust(16, ' ')
            limit.items[index].lim_am = item['amt'].to_s.rjust(13, ' ')
          end

          (requests.count..249).each  do |index|
            limit.items[index].card_no = ''.to_s.rjust(16, ' ')
            limit.items[index].lim_am = 0.to_s.ljust(13, ' ')
          end

          len = limit.to_binary_s.length

          limit.hdr_c = (len-4).to_s.rjust(4, '0')

          @queue[page_no] = limit

          page_no = page_no + 1


        end


        EM.add_timer(2) {
          p @queue[1].class.name
          @redis.publish('SAS.SEND', 1)
        }


      end

      # @items = LimitRequest.where(send_yn: false)







      # $redis.publish('SAS.MESSAGE', {item: 1111}.to_json)
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

      limit = Limit.read(buffer)

      Rails.logger.debug "process_message : #{limit}"

      # close_connection_after_writing
    end

    def self.startup

      # $redis = EM::Hiredis.connect

      $stdout.sync = true

      Rails.logger = Logger.new("#{Rails.root}/log/server_#{Rails.env}.log")


      EventMachine::run {
        # begin
        # rescue
        # end
        # @redis.publish('DRIVER.MESSAGE', {data: 111})

        # (1..10).each do |item|
        #   p "ITEM : #{item}"
        # end


        EventMachine::connect 'sas-card', 8888, Client
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
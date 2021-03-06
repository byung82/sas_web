module Sas

  class Server
    attr_accessor :connections, :queue

    def initialize
      @connections = []
      @queue = EM::Queue.new


      cb = Proc.new do |data|
        process_message(data)

        @queue.pop &cb
      end

      @queue.pop &cb
    end

    def process_message(data)
      Rails.logger.debug '메세지 큐처리'

      approval = data[:approval]

      ApprovalLog.transaction do
        ApprovalLog.create!(
            type_cd: 'P002',
            hdr_c: approval.hdr_c,
            tsk_dv_c: approval.tsk_dv_c,
            etxt_snrc_sn: approval.etxt_snrc_sn,
            trs_dt: approval.trs_dt,
            trs_t: approval.trs_t,
            rsp_c: approval.rsp_c,
            pprn1: approval.pprn1,
            card_no: approval.card_no,
            apr_dt: approval.apr_dt,
            apr_t: approval.apr_t,
            apr_no: approval.apr_no,
            apr_am: approval.apr_am,
            apr_can_yn: approval.apr_can_yn,
            apr_ts: approval.apr_ts,
            apr_can_dtm: approval.apr_can_dtm,
            mrc_no: approval.mrc_no,
            mrc_nm: approval.mrc_nm,
            bzr_no: approval.bzr_no,
            mrc_dlgps_nm: approval.mrc_dlgps_nm,
            mrc_tno: approval.mrc_tno,
            mrc_zip: approval.mrc_zip,
            mrc_adr: approval.mrc_adr,
            mrc_dtl_adr: approval.mrc_dtl_adr,
            pprn2: approval.pprn2)
      end

      if approval.apr_can_yn == 'N'
        approval.tsk_dv_c = '1100'
      else
        approval.tsk_dv_c = '2100'
      end

      begin

        card = StoreCard.find_by(card_no: approval.card_no.strip)

        if card.present? && card.business_no == '2258700196'
          url = 'https://checkcoin.co.kr/api/ext/kminlove/sas/usage'
          result = RestClient.post url, {
              card_no:  approval.card_no,
              amt: approval.apr_am.to_i,
              cancel_yn: approval.apr_can_yn,
              approval_no: approval.apr_no,
              approval_ymdhms: "#{approval.apr_dt}#{approval.apr_t}",
              cancel_ymdhms: approval.apr_can_dtm,
              store_name: approval.mrc_nm
          }

          p result
        end

      rescue => e
        Rails.logger.fatal "전송오류 처리 : #{e}"
      end

      approval.rsp_c = '0000'
      data[:client].send_data approval.to_binary_s
    rescue => e
      Rails.logger.warn "메세지큐 처리 오류 : #{e}"
      data[:client].close_connection_after_writing
    end

    def start
      @signature = EventMachine.start_server('0.0.0.0', 8888, Connection) do |con|
        con.server = self
      end
    end

    def stop
      EventMachine.stop_server(@signature)

      unless wait_for_connections_and_stop
        # Still some connections running, schedule a check later
        EventMachine.add_periodic_timer(1) { wait_for_connections_and_stop }
      end
    end

    def wait_for_connections_and_stop
      if @connections.empty?
        EventMachine.stop
        true
      else
        puts "Waiting for #{@connections.size} connection(s) to finish ..."
        false
      end
    end

    def self.startup
      Rails.logger = Logger.new("#{Rails.root}/log/server_#{Rails.env}.log")

      EventMachine::run {
        s = Server.new
        s.start
      }
    end
  end

  class Connection < EventMachine::Connection
    attr_accessor :server

    def unbind
      Rails.logger.debug '새로운접속 해제'
      server.connections.delete(self)
    end

    def post_init
      Rails.logger.debug '새로운접속'
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

      header = Sas::Packet::Header.read(buffer)

      Rails.logger.debug "HEADER : #{header}"

      if header.tsk_dv_c == '1000'
        Rails.logger.info '승인'

        # Rails.logger.info "BUFFER : #{buffer}, #{buffer.length}"

        item = Sas::Packet::Approval.read(buffer)

        server.queue.push({client: self, approval: item})

      elsif header.tsk_dv_c == '2001'
        Rails.logger.info '취소'
        item = Sas::Packet::Approval.read(buffer)
        server.queue.push({client: self, approval: item})
      else
        # Rails.logger.info "패킷헤더 오류 : #{header}"
        close_connection_after_writing
      end


      # close_connection_after_writing
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
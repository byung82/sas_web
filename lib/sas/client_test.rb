module Sas

  class ClientTest
    attr_accessor :connections, :queue

    def initialize
      @connections = []
    end

    def start
      @signature = EventMachine.start_server('0.0.0.0', 19703, ClientConnection) do |con|
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
      Rails.logger = Logger.new("#{Rails.root}/log/client_test_#{Rails.env}.log")

      EventMachine::run {
        s = ClientTest.new
        s.start
      }
    end
  end

  class ClientConnection < EventMachine::Connection
    attr_accessor :server

    def unbind
      Rails.logger.debug '새로운접속 해제'
      server.connections.delete(self)
    end

    def post_init
      p '================'
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


      p @len

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


      limit = Sas::Packet::Limit.read(buffer)

      limit.rsp_c = '0000'
      limit.tsk_dv_c = '2100'

      Rails.logger.debug "SEND DATA : #{limit.crtl_pge_no}, #{limit.wo_pge_n}"

      send_data limit.to_binary_s

      #
      # Rails.logger.debug "HEADER : #{header}"
      #
      # if header.tsk_dv_c == '1000'
      #   Rails.logger.info '승인'
      #
      #   Rails.logger.info "BUFFER : #{buffer}, #{buffer.length}"
      #
      #   item = Sas::Packet::Approval.read(buffer)
      #
      #   server.queue.push({client: self, approval: item})
      #
      # elsif header.tsk_dv_c == '2001'
      #   Rails.logger.info '취소'
      #   item = Sas::Packet::Approval.read(buffer)
      #   server.push({client: self, approval: item})
      # else
      #   Rails.logger.info "패킷헤더 오류 : #{header}"
      #   close_connection_after_writing
      # end


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
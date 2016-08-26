module Sas
  module ServerConnection

    attr_accessor :connections

    def initialize
      @connections = []
    end

    def post_init
      Rails.logger '새로운접속'
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

    def unbind
      Rails.logger '새로운접속 해제'
    end

    def process_message(buffer)

      header = Header.read(data)

      Rails.logger.debug "HEADER : #{header}"

      if header.tsk_dv_c == '1000'
        item = Approval.read(data)

      elsif header.tsk_dv_c == '2001'
        item = Approval.read(data)
      else

      end

    end
  end
end



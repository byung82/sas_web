module Sas

  class ServerTest < EventMachine::Connection
    def post_init

      now = Time.now.localtime

      data = Sas::Packet::Approval.new
      data.hdr_c = '1000'
      data.tsk_dv_c = '1000'
      data.etxt_snrc_sn = SecureRandom.random_number(9999999999).to_s.rjust(10, '0')
      data.trs_dt = now.strftime('%Y%m%d')
      data.trs_t = now.strftime('%H%M%S')
      data.rsp_c = '    '
      data.card_no = '9410852258688700'
      data.apr_dt = Time.now.localtime.strftime('%Y%m%d')
      data.apr_t = Time.now.localtime.strftime('%H%M%S')
      data.apr_no =  SecureRandom.random_number(99999999).to_s.rjust(8, '0')
      data.apr_am =  '1000'
      data.apr_can_yn =  'N'
      data.apr_ts =  '12345678901234567'
      data.apr_can_dtm =  '12345678901234'

      len = data.to_binary_s.length

      data.hdr_c = (len-4).to_s.rjust(4, '0')

      send_data data.to_binary_s

      close_connection_after_writing
    end

    def unbind
      EventMachine.stop
    end

    def self.startup
      EventMachine.run {
        EventMachine.connect '127.0.0.1', 8888, ServerTest
      }
      # Rails.logger = Logger.new("#{Rails.root}/log/server_#{Rails.env}.log")
      #
      # EventMachine::run {
      #   s = Server.new
      #   s.start
      # }
    end
  end


end
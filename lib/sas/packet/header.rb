module Sas
  module Packet
    class Header < BinData::Record
      # 전문구분코드
      string :hdr_c, read_length: 4
      # 전문구분코드
      string :tsk_dv_c, read_length: 4
      # 전문송수신일련번호
      string :etxt_snrc_sn, length: 10, pad_byte: ' '
      # # 전송일자
      string :trs_dt, read_length: 8
      # # 전송시간
      string :trs_t, read_length: 6
      # # 응답코드 0000:정상, 0010:거래중복, 0011:원거래없음, 0012:기취소, 0041:미존재카드, 0099:기타오류
      string :rsp_c, read_length: 4
      # # 예비1
      string :pprn1, length: 18, pad_byte: ' '
    end
  end
end

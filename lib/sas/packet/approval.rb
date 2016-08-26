require "#{Rails.root}/lib/sas/packet/euckr_string.rb"

module Sas
  module Packet
    class Approval < Header
      # # 카드번호
      string :card_no, read_length: 16
      # # 승인일자
      string :apr_dt, read_length: 8
      # # 승인시각
      string :apr_t, length: 6, pad_byte: ' '
      # 승인번호 취소시, 원거래의 승인번호
      string :apr_no, length: 8, pad_byte: ' '
      # 승인금액
      string :apr_am, length: 18, pad_byte: '0', pad_left: true
      # 승인취소여부 Y:취소완료
      string :apr_can_yn, read_length: 1
      # 승인상세일시 삼성카드 승인처리일시 yyyymmddhh24missSSS
      string :apr_ts, read_length: 17 , pad_byte: ' '
      # 승인취소일시 삼성카드 취소처리일시 yyyymmddhh24miss
      string :apr_can_dtm, read_length: 14, pad_byte: ' '
      # 가맹점번호
      string :mrc_no, length: 12, pad_byte: ' '
      # 가맹점명
      string :mrc_nm, length: 50, pad_byte: ' '
      # 사업자번호
      string :bzr_no, length: 10, pad_byte: ' '
      # 가맹점대표자명
      string :mrc_dlgps_nm, length: 12, pad_byte: ' '
      # 가맹점전화번호
      string :mrc_tno, length: 16, pad_byte: ' '
      # 가맹점우편번호
      string :mrc_zip, length: 6, pad_byte: ' '
      # 가맹점주소
      string :mrc_adr, length: 70, pad_byte: ' '
      # 가맹점상세주소
      string :mrc_dtl_adr,length: 70, pad_byte: ' '
      # 예비2
      string :pprn2, length: 16, pad_byte: ' '
    end
  end
end

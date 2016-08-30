
module Sas
  module Packet
    class Limit < Header
      # 사업자등록번호
      string :bzr_no, read_length: 10
      # 거래구분코드
      string :dlng_dv_c, read_length: 1
      # 현재페이지
      string :crtl_pge_no, read_length: 3, pad_byte: '0', pad_left: true
      string :wo_pge_n, read_length: 3, pad_byte: '0', pad_left: true
      array :items, :initial_length => 250 do
        # 카드번호
        string :card_no, read_length: 16, pad_byte: ' '

        # 한도금액
        string :lim_am, read_length: 13, pad_byte: '0', pad_left: true
      end
      # 예비2
      string :no2_trs_flr_cn, length: 112, pad_byte: ' '
    end
  end
end

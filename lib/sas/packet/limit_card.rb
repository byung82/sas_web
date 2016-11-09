
module Sas
  module Packet
    class LimitCard < Header
      #카드번호
      string :card_no, length: 16, pad_byte: ' '
      # 한도금액
      string :amt, length: 12, pad_byte: '0', pad_left: true
      # 예비
      string :pprn, length: 22, pad_byte: ' '
    end
  end
end

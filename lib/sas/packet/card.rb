module Sas
  module Packet
    class Card < BinData::Record
      # # 카드번호
      string :card_no, read_length: 16
      # # 승인일자
      string :tmp1, read_length: 3984
      # 가맹점번호
      string :business_no, length: 10, pad_byte: ' '
    end
  end
end
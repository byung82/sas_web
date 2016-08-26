module Sas
  module Packet
    class EUCKRString < BinData::String
      def snapshot
        super.encode('UTF-8', 'EUC-KR')
      end
    end
  end
end

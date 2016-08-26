module Sas
  module Packet
    class UTF8String < BinData::String
      def snapshot
        super.force_encoding('UTF-8')
      end
    end
  end
end

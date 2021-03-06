module Sas
  class Card
    def self.startup
      Rails.logger.info 'Sas::Card.startup'

      fileName = "#{Rails.configuration.card.path}/#{Time.now.localtime.strftime('%Y%m%d')}"

      File.readlines(fileName).each do |line|
        card =  Sas::Packet::Card.read line

        plsql.store_card_pkg.insert_store_card(card.business_no, card.card_no)

        # p "#{card.business_no}, #{card.card_no}"
      end

      Rails.logger.info 'Sas::Card.end'
    end
  end
end
module Sas
  Rails.logger = Logger.new("#{Rails.root}/log/card_#{Rails.env}.log")
  Card.startup
end
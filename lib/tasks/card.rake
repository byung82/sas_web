namespace :card do
  desc '사스 카드 데이터 로딩'
  task startup: :environment do
    Rails.logger = Logger.new("#{Rails.root}/log/server_#{Rails.env}.log")
    Sas::Card.startup
  end
end
namespace :server do
  desc '사스 통신 서버 실행'
  task startup: :environment do
    Rails.logger = Logger.new("#{Rails.root}/log/server_#{Rails.env}.log")
    Sas::Server.startup
  end

  desc '사스 통신 서버 테스트'
  task test: :environment do
    Rails.logger = Logger.new("#{Rails.root}/log/server_#{Rails.env}.log")
    Sas::ServerTest.startup
  end
end
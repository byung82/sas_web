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

  desc '사스 통신 클라잉언트 테스트'
  task client: :environment do
    Rails.logger = Logger.new("#{Rails.root}/log/client_test_#{Rails.env}.log")
    Sas::ClientTest.startup
  end

end
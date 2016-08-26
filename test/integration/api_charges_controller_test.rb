require 'test_helper'

class ApiChangesControllerTest < ActionDispatch::IntegrationTest
  test '접속테스트' do

    user = User.create(login: 'humoney', email: 'humoney@11.com', username: '휴머니', password: 'humoney00!@#', phone_no: 00000)


    app = Doorkeeper::Application.new :name => 'test', :redirect_uri => 'http://test.com'

    app.owner = user

    app.save


    client = OAuth2::Client.new(app.uid, app.secret) do |b|
      b.request :url_encoded
      b.adapter :rack, Rails.application
    end

    token = client.password.get_token('humoney', 'humoney00!@#')
    token.should_not be_expired
  end
end

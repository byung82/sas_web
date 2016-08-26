class LimitRequest < ActiveRecord::Base
  include UserInfo

  belongs_to :store

  belongs_to :store_card


  def response
    Api::V1::Response::Charge.create(self)
  end
end

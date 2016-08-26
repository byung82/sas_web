class Authority < ActiveRecord::Base
  include UserInfo

  # 회원 레벨
  has_many :user_authorities
  has_many :users, through: :user_authorities

end

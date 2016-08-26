class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include UserInfo

  # 권한관련
  has_many :user_authorities
  has_many :authorities, through: :user_authorities

  # OAuth application
  has_many :oauth_applications, class_name: 'Doorkeeper::Application', as: :owner, foreign_key: 'owner_id'

  # 회원
  has_many :store_users
  has_many :stores, through: :store_users


end

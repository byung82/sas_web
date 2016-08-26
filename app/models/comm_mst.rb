class CommMst < ActiveRecord::Base
  include UserInfo

  has_many :comm_dets
end

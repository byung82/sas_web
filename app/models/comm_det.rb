class CommDet < ActiveRecord::Base
  include UserInfo

  belongs_to :comm_mst
end

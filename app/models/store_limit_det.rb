class StoreLimitDet < ActiveRecord::Base
  belongs_to :store
  belongs_to :approval_log

  has_one    :status_txt,  -> { where(code: 'LIMIT_STATUS_CD')},
             :class_name => 'CommDet',
             foreign_key: :idty,
             primary_key: :status_cd
end

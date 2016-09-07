class StoreLimtDet < ActiveRecord::Base
  belongs_to :store

  has_one    :status_txt,  -> { where(code: 'LIMIT_STATUS_CD')},
             :class_name => 'CommDet',
             foreign_key: :idty,
             primary_key: :status_cd
end

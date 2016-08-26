class UserAuthority < ActiveRecord::Base
  belongs_to :user
  belongs_to :authority

  default_scope { where(deleted_yn: false) }

end

module UserInfo
  extend ActiveSupport::Concern
  included do
    belongs_to :created, class_name: 'User', foreign_key: 'created_id'
    belongs_to :updated, class_name: 'User', foreign_key: 'updated_id'
    belongs_to :deleted, class_name: 'User', foreign_key: 'deleted_id'
  end
end
class Store < ActiveRecord::Base
  include UserInfo

  before_create :process_lvl

  # TREE
  has_one :level, as: :levelable

  # 회원
  has_many :store_users
  has_many :users, through: :store_users, foreign_key: 'user_id', class_name: 'User'

  # 담당자
  belongs_to :manager, class_name: 'User', foreign_key: 'manager_id'

  has_many :store_cards

  # 카드한도 마스터
  has_many :store_limit_msts
  # 카드한도 상세
  has_many :store_limt_dets

  belongs_to :parent, class_name: 'Store', foreign_key: 'parent_id'

  has_many   :children,  foreign_key: :parent_id,  class_name:'Store'

  private
  def process_lvl

    if !self.level.present?
      return
    end

    if !self.parent.present?
      lvl = '000'
      limit = 3
    else
      parent_lvl = self.parent.level

      max = Store.joins(:level).
          where('levels.lvl like ?', "#{parent_lvl.lvl}%").
          where('length(levels.lvl) = ?', parent_lvl.lvl.length + 3).
          order('LEVELS.lvl desc').first

      lvl = max.present? ? max.level.lvl : "#{parent_lvl.lvl}000"

      limit = max.present? ? lvl.to_s.length : lvl.to_s.length
    end

    self.level.lvl = (lvl.to_i + 1).to_s.rjust(limit, '0')
  end
end

class Level < ActiveRecord::Base
  belongs_to :levelable, polymorphic: true
end

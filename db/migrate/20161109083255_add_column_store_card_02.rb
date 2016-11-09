class AddColumnStoreCard02 < ActiveRecord::Migration
  def change
    add_column :store_cards, :lookup_amt, :integer, default: 0
  end
end

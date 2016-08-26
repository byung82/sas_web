include MigrationHelper

class CreateStoreUsers < ActiveRecord::Migration
  def change
    create_table :store_users, id: false, comment: '가맹점 회원' do |t|
      t.integer :id, null: false, comment: '고유키'

      t.string :ymd, limit: 8, comment: '년월일'

      t.integer :seq, comment: '순번'

      t.belongs_to :user

      t.belongs_to :store

      t.timestamps null: false
    end

    add_index :store_users, [:ymd, :seq], unique: true, name: :store_users_idx_01
    add_index :store_users, :user_id, name: :store_users_idx_02
    add_index :store_users, :store_id, name: :store_users_idx_03

    reversible do |dir|
      dir.up do
        execute(change_primary_key(:store_users))

        execute(create_trigger(:store_users))
      end
    end
  end
end

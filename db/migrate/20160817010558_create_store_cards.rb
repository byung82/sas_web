include MigrationHelper

class CreateStoreCards < ActiveRecord::Migration
  def change
    create_table :store_cards, id: false, comment: '가맹점 카드정보 ' do |t|

      t.integer :id, null: false, comment: '고유키'

      t.string :ymd, limit: 8, comment: '년월일'

      t.integer :seq, comment: '순번'

      t.string :user_seq, limit: 100, comment: '카드사용자 고유키'

      t.belongs_to :store

      t.string :phone_no, limit: 20, comment: '휴대전화번호'

      t.string :business_no, limit: 10, comment: '휴대전화번호'

      t.string :card_no, limit: 16, comment: '카드번호'

      t.integer :limit_amt, comment: '한도'

      t.integer :sync_amt, comment: '연동 한도'

      t.boolean :lost_yn, default: 'N', comment: '분실여부'

      t.timestamps null: false
    end

    add_index :store_cards, [:ymd, :seq], unique: true, name: :store_cards_idx_01
    add_index :store_cards, :phone_no, name: :store_cards_idx_02
    add_index :store_cards, :card_no, name: :store_cards_idx_03
    # add_index :store_cards, :user_seq, name: :store_cards_idx_04
    # add_index :store_cards, :user_seq, name: :store_cards_idx_05

    reversible do |dir|
      dir.up do
        execute(change_primary_key(:store_cards))
      end
    end
  end
end
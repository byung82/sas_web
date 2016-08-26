include MigrationHelper

class CreateStoreLimitMsts < ActiveRecord::Migration
  def change
    create_table :store_limit_msts, comment: '카드 한도 사용 내역', id: false do |t|

      t.integer :id, null: false, comment: '고유키'

      t.string :ymd, limit: 8, comment: '년월일'

      t.integer :seq, comment: '순번'

      t.string :business_no, comment: '사업자등록번호'

      t.belongs_to :store, comment: '가맹점'

      t.belongs_to :store_card, comment: '사용자 FK', null: false

      t.string :card_no, limit: 16, comment: '카드번호', null: false

      t.integer :save, comment: '총 적립 금액'

      t.integer :used, comment: '총 사용 금액'

      t.integer :withdraw, comment: '총 출금 금액'

      t.integer :balance, comment: '잔액'

      t.string :st_key, comment: '업데이트 체크 키'

      t.timestamps null: false
    end

    add_index :store_limit_msts, [:ymd, :seq], unique: true, name: :store_limit_msts_idx_01
    add_index :store_limit_msts, :store_card_id,  name: :store_limit_msts_idx_02
    add_index :store_limit_msts, :card_no,  name: :store_limit_msts_idx_03
    add_index :store_limit_msts, :business_no,  name: :store_limit_msts_idx_04
    add_index :store_limit_msts, :store_id,  name: :store_limit_msts_idx_05
    add_index :store_limit_msts, :st_key,  name: :store_limit_msts_idx_06

    reversible do |dir|
      dir.up do
        execute(change_primary_key(:store_limit_msts))

        # execute(create_trigger(:store_limit_msts))
      end
    end
  end
end

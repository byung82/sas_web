class CreateCardSyncs < ActiveRecord::Migration
  def change
    create_table :card_syncs, id: false, comment: '카드 한도 동기화 테이블' do |t|

      t.integer :id, comment: '고유키'

      t.string :ymd, limit: 6, comment: '년월일'

      t.integer :seq, comment: '순번'

      t.string :business_no, limit: 10, comment: '사업자 등록번호'

      t.string :card_no, limit: 16, comment: '카드번호'

      t.integer :balance, default: 0, comment: '금액'

      t.datetime :sync_at, comment: '동기화 시간'
    end
  end
end

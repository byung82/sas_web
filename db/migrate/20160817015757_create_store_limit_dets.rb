include MigrationHelper

class CreateStoreLimitDets < ActiveRecord::Migration
  def change
    create_table :store_limit_dets, comment: '카드 한도 사용 내역', id: false do |t|

      t.integer :id, null: false, comment: '고유키'

      t.string :ymd, limit: 8, comment: '년월일'

      t.integer :seq, comment: '순번'

      t.string :business_no, comment: '사업자등록번호'

      t.string :user_seq, limit: 100, comment: '무기명 회원 FK'

      t.belongs_to :approval_log, comment: '통신로그 FK'

      t.belongs_to :limit_log, comment: '한도 FK'

      t.belongs_to :store, comment: '가맹점'

      t.belongs_to :store_limit_mst

      t.belongs_to :store_card, comment: '사용자 FK'

      t.string :card_no, limit: 16, comment: '카드번호'

      t.string :status_cd, limit: 20, comment: '상태코드'

      t.integer :amt, comment: '적립/사용/출금 금액'

      t.integer :balance, comment: '잔액'

      t.timestamps null: false
    end

    add_index :store_limit_dets, [:ymd, :seq], unique: true, name: :store_limit_dets_idx_01
    add_index :store_limit_dets, :store_limit_mst_id,  name: :store_limit_dets_idx_02
    add_index :store_limit_dets, :store_card_id,  name: :store_limit_dets_idx_03
    add_index :store_limit_dets, :card_no,  name: :store_limit_dets_idx_04
    add_index :store_limit_dets, :status_cd,  name: :store_limit_dets_idx_05
    add_index :store_limit_dets, :business_no,  name: :store_limit_dets_idx_06
    add_index :store_limit_dets, :store_id,  name: :store_limit_msts_idx_07
    add_index :store_limit_dets, :user_seq,  name: :store_limit_msts_idx_08

    reversible do |dir|
      dir.up do
        execute(change_primary_key(:store_limit_dets))

        u = User.find_by(email: 'system@kminlove.com')

        c = CommMst.find_or_initialize_by(code: 'LIMIT_STATUS_CD', explan: '한도 상향/하양 코드', created: u, updated: u)

        if c.new_record?

          c.save!

          CommDet.find_or_create_by!(comm_mst: c,
                                     code: 'LIMIT_STATUS_CD', idty: 'LS001',
                                     sval1: '충전', explan: '한도 상향/하양 코드',
                                     created: u, updated: u)

          CommDet.find_or_create_by!(comm_mst: c,
                                     code: 'LIMIT_STATUS_CD', idty: 'LS002',
                                     sval1: '사용', explan: '한도 상향/하양 코드',
                                     created: u, updated: u)

          CommDet.find_or_create_by!(comm_mst: c,
                                     code: 'LIMIT_STATUS_CD', idty: 'LS003',
                                     sval1: '취소', explan: '한도 상향/하양 코드',
                                     created: u, updated: u)

          CommDet.find_or_create_by!(comm_mst: c,
                                     code: 'LIMIT_STATUS_CD', idty: 'LS004',
                                     sval1: '출금요청', explan: '한도 상향/하양 코드',
                                     created: u, updated: u)

          CommDet.find_or_create_by!(comm_mst: c,
                                     code: 'LIMIT_STATUS_CD', idty: 'LS005',
                                     sval1: '출금완료', explan: '한도 상향/하양 코드',
                                     created: u, updated: u)

        end


        # execute(create_trigger(:store_limit_dets))
      end
    end
  end
end

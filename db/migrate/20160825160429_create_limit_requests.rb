
include MigrationHelper

class CreateLimitRequests < ActiveRecord::Migration
  def change
    create_table :limit_requests, id: false, comment: '한도요청 테이블' do |t|

      t.integer :id, comment: '고유키'
      
      t.string :ymd, limit: 6, comment: '년월일'
      
      t.integer :seq, comment: '순번'

      t.string :type_cd, limit: 20, comment: '충전방식'

      t.string :limit_cd, limit: 20, comment: '상향/햐양'

      t.string :business_no, limit: 10, comment: '사업자등록번호'
      
      t.string :card_no, limit: 16, comment: '카드번호'
      
      t.integer :amt, comment: '충전 금액'

      t.boolean :send_yn, default: 'N', comment: '전송 여부'
      
      t.boolean :error_yn, default: 'N', comment: '한도증액 오류 여부'

      t.string :code, limit: 4, comment: '상태코드'

      t.belongs_to :store

      t.belongs_to :store_card

      t.belongs_to :created
      
      t.belongs_to :updated
      
      t.timestamps null: false
    end

    add_index :limit_requests, [:ymd, :seq], unique: true, name: :limit_requests_idx_01
    add_index :limit_requests, :send_yn, name: :limit_requests_idx_02
    add_index :limit_requests, :error_yn, name: :limit_requests_idx_03
    add_index :limit_requests, :business_no, name: :limit_requests_idx_04
    add_index :limit_requests, :created_id, name: :limit_requests_idx_05
    add_index :limit_requests, :updated_id, name: :limit_requests_idx_06
    add_index :limit_requests, :store_id, name: :limit_requests_idx_07
    add_index :limit_requests, :store_card_id, name: :limit_requests_idx_08

    reversible do |dir|
      dir.up do
        execute(change_primary_key(:limit_requests))

        execute(create_trigger(:limit_requests))

        u = User.find_by(email: 'system@kminlove.com')

        c = CommMst.find_or_initialize_by(code: 'CHARGE_TYPE_CD', explan: '충전방식', created: u, updated: u)

        if c.new_record?

          c.save!

          CommDet.find_or_create_by!(comm_mst: c,
                                     code: 'CHARGE_TYPE_CD', idty: 'CT001',
                                     sval1: '가상계좌', explan: '충전방식',
                                     created: u, updated: u)

          CommDet.find_or_create_by!(comm_mst: c,
                                     code: 'CHARGE_TYPE_CD', idty: 'CT002',
                                     sval1: '카드', explan: '충전방식',
                                     created: u, updated: u)

          CommDet.find_or_create_by!(comm_mst: c,
                                     code: 'CHARGE_TYPE_CD', idty: 'CT003',
                                     sval1: '무통장', explan: '충전방식',
                                     created: u, updated: u)

          CommDet.find_or_create_by!(comm_mst: c,
                                     code: 'CHARGE_TYPE_CD', idty: 'CT004',
                                     sval1: '코인', explan: '충전방식',
                                     created: u, updated: u)

          CommDet.find_or_create_by!(comm_mst: c,
                                     code: 'CHARGE_TYPE_CD', idty: 'CT005',
                                     sval1: '동기화', explan: '충전방식',
                                     created: u, updated: u)
        end

        c = CommMst.find_or_initialize_by(code: 'CHARGE_LIMIT_CD', explan: '한도코드', created: u, updated: u)

        if c.new_record?

          c.save!

          CommDet.find_or_create_by!(comm_mst: c,
                                     code: 'CHARGE_LIMIT_CD', idty: 'CL001',
                                     sval1: '충전', explan: '한도코드',
                                     created: u, updated: u)

          CommDet.find_or_create_by!(comm_mst: c,
                                     code: 'CHARGE_TYPE_CD', idty: 'CL002',
                                     sval1: '차감', explan: '한도코드',
                                     created: u, updated: u)

          CommDet.find_or_create_by!(comm_mst: c,
                                     code: 'CHARGE_TYPE_CD', idty: 'CL003',
                                     sval1: '동기화', explan: '한도코드',
                                     created: u, updated: u)
        end
      end
    end
  end   
end

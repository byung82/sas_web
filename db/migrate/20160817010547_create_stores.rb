include MigrationHelper

class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores, id: false, comment: '가맹점' do |t|
      t.integer :id, null: false, comment: '고유키'

      t.belongs_to :parent, comment: '상위 ID'

      t.string :ymd, limit: 8, comment: '년월일'

      t.integer :seq, comment: '순번'

      t.string :store_name, limit: 100, comment: '가맹점 정보'

      t.string :business_no, limit: 10, comment: '사업자등록번호'

      t.string :phone_no, limit: 20, comment: '전화번호'

      t.string :email, comment: '이메일주소
'
      t.string :ceo_name, limit: 100, comment: '대표자명'

      t.string :zone_code, limit: 5, comment: '우편번호'

      t.string :addr1, limit: 150, comment: '주소'

      t.string :addr2, limit: 100, comment: '상세주소'

      t.float :lat, comment: '위도'

      t.float :lng, comment: '경도'

      t.belongs_to :created, comment: '생성자'

      t.belongs_to :updated, comment: '수정자'

      t.belongs_to :deleted, comment: '삭제자'

      t.belongs_to :manager, comment: '담당자'

      t.string :status_cd, limit: 20, comment: '상태코드', default: 'SS001'

      t.boolean :deleted_yn, default: 'N', comment: '삭제여부'

      t.timestamps null: false, comment: '수정 삭제일'

      t.datetime :deleted_at, comment: '삭제일'
    end

    add_index :stores, [:ymd, :seq], unique: true, name: :stores_idx_01
    add_index :stores, :status_cd, name: :stores_idx_02
    add_index :stores, :store_name, name: :stores_idx_03
    add_index :stores, :business_no, unique: true, name: :stores_idx_04
    add_index :stores, :created_id, name: :stores_idx_05
    add_index :stores, :updated_id, name: :stores_idx_06
    add_index :stores, :manager_id, name: :stores_idx_07
    add_index :stores, :parent_id, name: :stores_idx_08
    add_index :stores, :deleted_id, name: :stores_idx_09

    reversible do |dir|
      dir.up do
        execute(change_primary_key(:stores))

        execute(create_trigger(:stores))

        u = User.find_by(email: 'system@kminlove.com')

        c = CommMst.find_or_initialize_by(code: 'STORE_STATUS_CD', explan: '가맹점', created: u, updated: u)

        if c.new_record?

          c.save!

          CommDet.find_or_create_by!(comm_mst: c,
                                     code: 'STORE_STATUS_CD', idty: 'SS001',
                                     sval1: '사용대기', explan: '가맹점 사용 상태',
                                     created: u, updated: u)

          CommDet.find_or_create_by!(comm_mst: c,
                                     code: 'STORE_STATUS_CD', idty: 'SS002',
                                     sval1: '사용', explan: '가맹점 사용 상태',
                                     created: u, updated: u)

          CommDet.find_or_create_by!(comm_mst: c,
                                     code: 'STORE_STATUS_CD', idty: 'SS003',
                                     sval1: '사용중지', explan: '가맹점 사용 상태',
                                     created: u, updated: u)

        end


        s = Store.find_or_initialize_by(business_no: '4658700076')

        if s.new_record?
          s.store_name = '국민사랑'
          s.phone_no = '1644-7909'
          s.ceo_name = '박성호'
          s.zone_code = '11111'
          s.addr1 = '대구시 중구 공평로 20'
          s.addr2 = '삼성빌딩 8층'
          s.created = u
          s.updated = u

          s.users << ::User.find_by(email: 'byung82@kminlove.com')
          s.build_level
          s.save!

          u1 = ::User.find_or_initialize_by(email: 'humoney@11.com')


          s1 = Store.new
          s1.business_no = '6818100394'
          s1.store_name = '휴머니'
          s1.ceo_name = 'CEO'
          s1.zone_code = '11111'
          s1.addr1 = '주소'
          s1.addr2 = '상세'
          s1.phone_no = '11111111'
          s1.build_level
          s1.created = u1
          s1.updated = u1
          s1.parent = s

          #
          #
          # if u1.new_record?
          #   u1.email = 'manager@happymade.com'
          #   u1.password = '11111111'
          #   u1.username = '해피메이드'
          #   u1.nickname = '해피메이드'
          #   u1.login = 'happymade'
          #   u1.phone_no = '00011112223'
          #   u1.authorities << Authority.find_by(code: 'R900')
          #   u1.save!
          # end
          #
          # s1.manager = u1
          # s1.users << u1
          # s1.save!

        end
      end
    end
  end
end

include MigrationHelper

class CreateCommDets < ActiveRecord::Migration
  def change
    create_table :comm_dets, id: false, comment: '공통코드 상세' do |t|
      t.string   :id, null: false, comment: '고유키'

      t.string   :ymd,       limit: 8, comment: '년월일'

      t.integer  :seq,       comment: '순번'

      t.belongs_to :comm_mst, comment: 'comm_dets FK'

      t.string :code, limit: 20, comment: '코드'

      t.string :idty, limit: 20, comment: 'idty'

      t.string :explan, limit: 100, comment: '설명'

      t.boolean :deleted_yn, default: false, comment: '사용여부'

      t.string :sval1, comment: '문자열값 1'
      t.string :sval2, comment: '문자열값 2'
      t.string :sval3, comment: '문자열값 3'
      t.string :sval4, comment: '문자열값 3'
      t.string :sval5, comment: '문자열값 5'
      t.string :sval6, comment: '문자열값 6'
      t.string :sval7, comment: '문자열값 7'
      t.string :sval8, comment: '문자열값 8'
      t.string :sval9, comment: '문자열값 9'
      t.string :sval10, comment: '문자열값 10'

      t.decimal :val1, precision: 10, scale: 3, comment: '숫자값 1'
      t.decimal :val2, precision: 10, scale: 3, comment: '숫자값 2'
      t.decimal :val3, precision: 10, scale: 3, comment: '숫자값 3'
      t.decimal :val4, precision: 10, scale: 3, comment: '숫자값 4'
      t.decimal :val5, precision: 10, scale: 3, comment: '숫자값 5'
      t.decimal :val6, precision: 10, scale: 3, comment: '숫자값 6'
      t.decimal :val7, precision: 10, scale: 3, comment: '숫자값 7'
      t.decimal :val8, precision: 10, scale: 3, comment: '숫자값 8'
      t.decimal :val9, precision: 10, scale: 3, comment: '숫자값 9'
      t.decimal :val10, precision: 10, scale: 3, comment: '숫자값 10'


      t.belongs_to :created, comment: '생성자'

      t.belongs_to :updated, comment: '수정자'

      t.belongs_to :deleted, comment: '삭제자'

      t.timestamps null: false

      t.datetime :deleted_at, comment: '삭제일'
    end

    add_index :comm_dets, [:ymd, :seq], unique: true, name: :comm_dets_idx_01

    add_index :comm_dets, [:code, :idty], unique: true, name: :comm_dets_idx_02

    add_index :comm_dets, :deleted_yn, name: :comm_dets_idx_03

    add_index :comm_dets, :comm_mst_id, name: :comm_dets_idx_04

    add_index :comm_dets, :created_id, name: :comm_dets_idx_05

    add_index :comm_dets, :updated_id, name: :comm_dets_idx_06

    add_index :comm_dets, :deleted_id, name: :comm_dets_idx_07

    reversible do |dir|
      dir.up do
        execute(change_primary_key(:comm_dets))

        execute(create_trigger(:comm_dets))

        # u = User.find_by(email: 'system@mgm.com')
        #
        # c = CommMst.find_or_initialize_by(code: 'BANK', explan: '은행코드', created: u, updated: u)
        #
        # if c.new_record?
        #
        #   c.save!
        #
        #   CommDet.find_or_create_by!(comm_mst_id: c.id,
        #                              code: 'BANK', idty: '002',
        #                              sval1: '산업은행', explan: '은행코드',
        #                              created_id: u.id, updated_id: u.id)
        #
        #   CommDet.find_or_create_by!(comm_mst_id: c.id,
        #                              code: 'BANK', idty: '003',
        #                              sval1: '기업은행', explan: '은행코드',
        #                              created_id: u.id, updated_id: u.id)
        #
        #   CommDet.find_or_create_by!(comm_mst_id: c.id,
        #                              code: 'BANK', idty: '004',
        #                              sval1: '국민은행', explan: '은행코드',
        #                              created_id: u.id, updated_id: u.id)
        #
        #   CommDet.find_or_create_by!(comm_mst_id: c.id,
        #                              code: 'BANK', idty: '005',
        #                              sval1: '외한은행', explan: '은행코드',
        #                              created_id: u.id, updated_id: u.id)
        #
        #
        #   CommDet.find_or_create_by!(comm_mst_id: c.id,
        #                              code: 'BANK', idty: '008',
        #                              sval1: '수출입은행', explan: '은행코드',
        #                              created_id: u.id, updated_id: u.id)
        #
        #   CommDet.find_or_create_by!(comm_mst_id: c.id,
        #                              code: 'BANK', idty: '011',
        #                              sval1: 'NH농협은행', explan: '은행코드',
        #                              created_id: u.id, updated_id: u.id)
        #
        #   CommDet.find_or_create_by!(comm_mst_id: c.id,
        #                              code: 'BANK', idty: '012',
        #                              sval1: '지역 농·축협', explan: '은행코드',
        #                              created_id: u.id, updated_id: u.id)
        #
        #   CommDet.create!(comm_mst_id: c.id,
        #                   code: 'BANK', idty: '020',
        #                   sval1: '우리은행', explan: '은행코드',
        #                   created_id: u.id, updated_id: u.id)
        #
        #   CommDet.find_or_create_by!(comm_mst_id: c.id,
        #                              code: 'BANK', idty: '023',
        #                              sval1: '한국스탠다드차타드은행', explan: '은행코드',
        #                              created_id: u.id, updated_id: u.id)
        #
        #   CommDet.find_or_create_by!(comm_mst_id: c.id,
        #                              code: 'BANK', idty: '027',
        #                              sval1: '한국씨티은행', explan: '은행코드',
        #                              created_id: u.id, updated_id: u.id)
        #
        #   CommDet.find_or_create_by!(comm_mst_id: c.id,
        #                              code: 'BANK', idty: '031',
        #                              sval1: '대구은행', explan: '은행코드',
        #                              created_id: u.id, updated_id: u.id)
        #
        #   CommDet.find_or_create_by!(comm_mst_id: c.id,
        #                              code: 'BANK', idty: '032',
        #                              sval1: '부산은행', explan: '은행코드',
        #                              created_id: u.id, updated_id: u.id)
        #
        #   CommDet.find_or_create_by!(comm_mst_id: c.id,
        #                              code: 'BANK', idty: '034',
        #                              sval1: '광주은행', explan: '은행코드',
        #                              created_id: u.id, updated_id: u.id)
        #
        #   CommDet.find_or_create_by!(comm_mst_id: c.id,
        #                              code: 'BANK', idty: '035',
        #                              sval1: '제주은행', explan: '은행코드',
        #                              created_id: u.id, updated_id: u.id)
        #
        #   CommDet.find_or_create_by!(comm_mst_id: c.id,
        #                              code: 'BANK', idty: '037',
        #                              sval1: '전북은행', explan: '은행코드',
        #                              created_id: u.id, updated_id: u.id)
        #
        #   CommDet.create!(comm_mst_id: c.id,
        #                   code: 'BANK', idty: '039',
        #                   sval1: '경남은행', explan: '은행코드',
        #                   created_id: u.id, updated_id: u.id)
        #
        #   CommDet.find_or_create_by!(comm_mst_id: c.id,
        #                              code: 'BANK', idty: '081',
        #                              sval1: '하나은행', explan: '은행코드',
        #                              created_id: u.id, updated_id: u.id)
        #
        #   CommDet.create!(comm_mst_id: c.id,
        #                   code: 'BANK', idty: '088',
        #                   sval1: '신한은행', explan: '은행코드',
        #                   created_id: u.id, updated_id: u.id)
        #
        #   CommDet.find_or_create_by!(comm_mst_id: c.id,
        #                              code: 'BANK', idty: '045',
        #                              sval1: '새마을금고', explan: '은행코드',
        #                              created_id: u.id, updated_id: u.id)
        #
        #   CommDet.find_or_create_by!(comm_mst_id: c.id,
        #                              code: 'BANK', idty: '048',
        #                              sval1: '신용협동조합', explan: '은행코드',
        #                              created_id: u.id, updated_id: u.id)
        #
        #   CommDet.find_or_create_by!(comm_mst_id: c.id,
        #                              code: 'BANK', idty: '050',
        #                              sval1: '상호저축은행', explan: '은행코드',
        #                              created_id: u.id, updated_id: u.id)
        #
        #   CommDet.find_or_create_by!(comm_mst_id: c.id,
        #                              code: 'BANK', idty: '054',
        #                              sval1: 'HSBC 서울지점', explan: '은행코드',
        #                              created_id: u.id, updated_id: u.id)
        #
        #   CommDet.find_or_create_by!(comm_mst_id: c.id,
        #                              code: 'BANK', idty: '064',
        #                              sval1: '산림조합', explan: '은행코드',
        #                              created_id: u.id, updated_id: u.id)
        #
        #   CommDet.find_or_create_by!(comm_mst_id: c.id,
        #                              code: 'BANK', idty: '071',
        #                              sval1: '우체국', explan: '은행코드',
        #                              created_id: u.id, updated_id: u.id)
        #
        # end


        # c = CommMst.find_or_initialize_by(code: 'USER_STATUS_CD', explan: '회원상태', created: u, updated: u)
        #
        #
        # if c.new_record?
        #   c.save!
        #
        #   CommDet.find_or_create_by!(comm_mst_id: c.id,
        #                              code: 'USER_STATUS_CD', idty: 'US001',
        #                              sval1: '사용', explan: '사용자상태',
        #                              created_id: u.id, updated_id: u.id)
        #
        #   CommDet.find_or_create_by!(comm_mst_id: c.id,
        #                              code: 'USER_STATUS_CD', idty: 'US002',
        #                              sval1: '정지', explan: '사용자상태',
        #                              created_id: u.id, updated_id: u.id)
        # end
        #
        #
        # c = CommMst.find_or_initialize_by(code: 'CARD_BIN_CODE', explan: '카드 BIN CODE', created: u, updated: u)
        #
        # if c.new_record?
        #
        #   c.save!
        #
        #   # xlsx = Roo::Excelx.new("#{Rails.root}/lib/card_bin_code.xlsx")
        #   #
        #   # header = xlsx.row(1)
        #   #
        #   # p 'START INSERT CARD BIN CODE'
        #   # (1..xlsx.last_row).each do |i|
        #   #   row = Hash[[header, xlsx.row(i)].transpose]
        #   #
        #   #   CommDet.find_or_create_by!(comm_mst: c,
        #   #                              code: 'CARD_BIN_CODE', idty: row['CODE'],
        #   #                              sval1: row['NAME'], explan: '카드빈코드',
        #   #                              created_id: u.id, updated_id: u.id)
        #   #
        #   # end
        #   # p 'END INSERT CARD BIN CODE'
        # end
      end
    end

  end
end

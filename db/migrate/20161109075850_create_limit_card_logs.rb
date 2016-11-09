include MigrationHelper

class CreateLimitCardLogs < ActiveRecord::Migration
  def change
    create_table :limit_card_logs, id: false, comment: '카드한도 조호 로그 테이블' do |t|

      t.integer :id, null: false, comment: '고유키'
  
      t.string :ymd, limit: 8, comment: '년월일'

      t.integer :seq, comment: '순번'

      t.string :type_cd, liimit: 20, comment: 'P001:전송패킷, P002: 수신패킷', default: 'P002'

      t.string :hdr_c, limit: 4, comment: '패킷LEN'
      # 전문구분코드
      t.string :tsk_dv_c, limit: 4, comment: '전문구분코드'
      # 전문송수신일련번호
      t.string :etxt_snrc_sn, limit: 10, comment: '전문송수신일련번호'
      # 전송일자
      t.string :trs_dt, limit: 8, comment: '전송일자'
      # 전송시간
      t.string :trs_t, limit: 6, comment: '전송시간'
      # 응답코드 0000:정상, 0010:거래중복, 0011:원거래없음, 0012:기취소, 0041:미존재카드, 0099:기타오류
      t.string :rsp_c, limit: 4, comment: '응답코드 0000:정상, 0010:거래중복, 0011:원거래없음, 0012:기취소, 0041:미존재카드, 0099:기타오류'
      # 예비1
      t.string :pprn1, limit: 18, comment: '예비1'

      t.string :card_no, limit: 16, comment: '카드번호'
      # 한도금액
      t.string :amt, length: 12, comment: '한도금액'
      # 예비
      t.string :pprn2, length: 22, comment: '예비'
      
      t.timestamps null: false
    end

    add_index :limit_card_logs, [:ymd, :seq], unique: true, name: :limit_card_logs_idx_01
    add_index :limit_card_logs, :type_cd, name: :limit_card_logs_idx_02
    add_index :limit_card_logs, :card_no, name: :limit_card_logs_idx_03


    reversible do |dir|
      dir.up do
        execute(change_primary_key(:limit_card_logs))
      end
    end
  end
end

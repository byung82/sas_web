include MigrationHelper

class CreateApprovalLogs < ActiveRecord::Migration
  def change
    create_table :approval_logs, id: false do |t|

      t.integer :id, comment: '고유키'

      t.string :ymd, limit: 8, comment: '년월일'

      t.integer :seq, comment: '순번'

      t.string :type_cd, liimit: 20, comment: 'P001:전송패킷, P002: 수신패킷', default: 'P002'



      t.string :hdr_c, limit: 4, comment: '패킷LEN'
      # 전문구분코드
      t.string :tsk_dv_c, limit: 4, comment: '전문구분코드'
      # 전문송수신일련번호
      t.string :etxt_snrc_sn, limit: 10, comment: '전문송수신일련번호'
      # # 전송일자
      t.string :trs_dt, limit: 8, comment: '전송일자'
      # # 전송시간
      t.string :trs_t, limit: 6, comment: '전송시간'
      # # 응답코드 0000:정상, 0010:거래중복, 0011:원거래없음, 0012:기취소, 0041:미존재카드, 0099:기타오류
      t.string :rsp_c, limit: 4, comment: '응답코드 0000:정상, 0010:거래중복, 0011:원거래없음, 0012:기취소, 0041:미존재카드, 0099:기타오류'
      # # 예비1
      t.string :pprn1, limit: 18, comment: '예비1'
      # # 카드번호
      t.string :card_no, limit: 16, comment: '카드번호'
      # # 승인일자
      t.string :apr_dt, limit: 8, comment: '승인일자'
      # # 승인시각
      t.string :apr_t, limit: 6, comment: '승인시각'
      # 승인번호 취소시, 원거래의 승인번호
      t.string :apr_no, limit: 8, comment: '승인번호 취소시, 원거래의 승인번호'
      # 승인금액
      t.string :apr_am, limit: 18, comment: '승인시각'
      # 승인취소여부 Y:취소완료
      t.string :apr_can_yn, limit: 1, comment: '승인취소여부 Y:취소완료'
      # 승인상세일시 삼성카드 승인처리일시 yyyymmddhh24missSSS
      t.string :apr_ts, limit: 17, comment: '승인상세일시 삼성카드 승인처리일시 yyyymmddhh24missSSS'
      # 승인취소일시 삼성카드 취소처리일시 yyyymmddhh24miss
      t.string :apr_can_dtm, limit: 14, comment: '승인취소일시 삼성카드 취소처리일시 yyyymmddhh24miss'
      # 가맹점번호
      t.string :mrc_no, limit: 12, comment: '가맹점번호'
      # 가맹점명
      t.string :mrc_nm, limit: 50, comment: '가맹점명'
      # 사업자번호
      t.string :bzr_no, limit: 10, comment: '사업자번호'
      # 가맹점대표자명
      t.string :mrc_dlgps_nm, limit: 12, comment: '가맹점대표자명'
      # 가맹점전화번호
      t.string :mrc_tno, limit: 16, comment: '가맹점전화번호'
      # 가맹점우편번호
      t.string :mrc_zip, limit: 6, comment: '가맹점우편번호'
      # 가맹점주소
      t.string :mrc_adr, limit: 70, comment: '가맹점주소'
      # 가맹점상세주소
      t.string :mrc_dtl_adr,limit: 70, comment: '가맹점상세주소'
      # 예비2
      t.string :pprn2, limit: 16, comment: '예비2'

      t.timestamps null: false
    end

    add_index :approval_logs, [:ymd, :seq], unique: true, name: :approval_logs_idx_01
    add_index :approval_logs, :type_cd, name: :approval_logs_idx_02
    add_index :approval_logs, :card_no, name: :approval_logs_idx_03




    reversible do |dir|
      dir.up do
        execute(change_primary_key(:approval_logs))

      end
    end
  end
end

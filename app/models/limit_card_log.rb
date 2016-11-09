class LimitCardLog < ActiveRecord::Base
  include ActiveRecord::OracleEnhancedProcedures

  set_create_method do
    plsql.limit_card_pkg.insert_limit_card_log(
        i_type_cd: type_cd,
        i_hdr_c: hdr_c,
        i_tsk_dv_c: tsk_dv_c,
        i_etxt_snrc_sn: etxt_snrc_sn,
        i_trs_dt: trs_dt,
        i_trs_t: trs_t,
        i_rsp_c: rsp_c,
        i_pprn1: pprn1,
        i_card_no: card_no,
        i_amt: amt,
        i_pprn2: pprn2
    )[:o_id]
  end
end

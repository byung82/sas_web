class LimitLog < ActiveRecord::Base
  include ActiveRecord::OracleEnhancedProcedures

  set_create_method do
    plsql.log_pkg.insert_limit_logs(
        i_type_cd: type_cd,
        i_hdr_c: hdr_c,
        i_tsk_dv_c: tsk_dv_c,
        i_etxt_snrc_sn: etxt_snrc_sn,
        i_trs_dt: trs_dt,
        i_trs_t: trs_t,
        i_rsp_c: rsp_c,
        i_pprn1: pprn1,
        i_bzr_no: bzr_no,
        i_dlng_dv_c: dlng_dv_c == 'U000' ? 'U' : 'N',
        i_crtl_pge_no: crtl_pge_no,
        i_wo_pge_n: wo_pge_n,
        i_card: card,
        i_no2_trs_flr_cn: no2_trs_flr_cn
    )[:o_id]
  end
end

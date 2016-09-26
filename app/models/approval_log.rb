class ApprovalLog < ActiveRecord::Base

  include ActiveRecord::OracleEnhancedProcedures

  # when defining create method then return ID of new record that will be assigned to id attribute of new object
  set_create_method do

    Rails.logger.debug "apr_can_yn : #{apr_can_yn}"

    plsql.log_pkg.insert_approval(
        i_type_cd: type_cd,
        i_hdr_c: hdr_c,
        i_tsk_dv_c: tsk_dv_c,
        i_etxt_snrc_sn: etxt_snrc_sn,
        i_trs_dt: trs_dt,
        i_trs_t: trs_t,
        i_rsp_c: rsp_c,
        i_pprn1: pprn1,
        i_card_no: card_no,
        i_apr_dt: apr_dt,
        i_apr_t: apr_t,
        i_apr_no: apr_no,
        i_apr_am: apr_am,
        i_apr_can_yn: apr_can_yn == true ? 'Y' : 'N',
        i_apr_ts: apr_ts,
        i_apr_can_dtm: apr_can_dtm,
        i_mrc_no: mrc_no,
        i_mrc_nm: mrc_nm,
        i_bzr_no: bzr_no,
        i_mrc_dlgps_nm: mrc_dlgps_nm,
        i_mrc_tno: mrc_tno,
        i_mrc_zip: mrc_zip,
        i_mrc_adr: mrc_adr,
        i_mrc_dtl_adr: mrc_dtl_adr,
        i_pprn2: pprn2
    )[:o_id]
  end

end

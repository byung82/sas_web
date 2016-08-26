class CreateApprovalLogPackage < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        sql = <<-SQL
create or replace PACKAGE LOG_PKG AS

  PROCEDURE INSERT_APPROVAL(I_TYPE_CD IN VARCHAR2,
                            I_HDR_C IN VARCHAR2,
                            I_TSK_DV_C IN VARCHAR2,
                            I_ETXT_SNRC_SN IN VARCHAR2,
                            I_TRS_DT  IN VARCHAR2,
                            I_TRS_T IN VARCHAR2,
                            I_RSP_C IN VARCHAR2,
                            I_PPRN1 IN VARCHAR2,
                            I_CARD_NO IN VARCHAR2,
                            I_APR_DT IN VARCHAR2,
                            I_APR_T IN VARCHAR2,
                            I_APR_NO IN VARCHAR2,
                            I_APR_AM IN VARCHAR2,
                            I_APR_CAN_YN IN VARCHAR2,
                            I_APR_TS IN VARCHAR2,
                            I_APR_CAN_DTM IN VARCHAR2,
                            I_MRC_NO IN VARCHAR2,
                            I_MRC_NM IN VARCHAR2,
                            I_BZR_NO IN VARCHAR2,
                            I_MRC_DLGPS_NM IN VARCHAR2,
                            I_MRC_TNO IN VARCHAR2,
                            I_MRC_ZIP IN VARCHAR2,
                            I_MRC_ADR IN VARCHAR2,
                            I_MRC_DTL_ADR IN VARCHAR2,
                            I_PPRN2 IN VARCHAR2,
                            I_CREATED_AT IN DATE,
                            I_UPDATED_AT IN DATE,
                            O_ID OUT NUMBER);

END LOG_PKG;
        SQL

        execute sql

        sql = <<-SQL
create or replace PACKAGE BODY LOG_PKG AS

  PROCEDURE INSERT_APPROVAL(I_TYPE_CD IN VARCHAR2,
                            I_HDR_C IN VARCHAR2,
                            I_TSK_DV_C IN VARCHAR2,
                            I_ETXT_SNRC_SN IN VARCHAR2,
                            I_TRS_DT  IN VARCHAR2,
                            I_TRS_T IN VARCHAR2,
                            I_RSP_C IN VARCHAR2,
                            I_PPRN1 IN VARCHAR2,
                            I_CARD_NO IN VARCHAR2,
                            I_APR_DT IN VARCHAR2,
                            I_APR_T IN VARCHAR2,
                            I_APR_NO IN VARCHAR2,
                            I_APR_AM IN VARCHAR2,
                            I_APR_CAN_YN IN VARCHAR2,
                            I_APR_TS IN VARCHAR2,
                            I_APR_CAN_DTM IN VARCHAR2,
                            I_MRC_NO IN VARCHAR2,
                            I_MRC_NM IN VARCHAR2,
                            I_BZR_NO IN VARCHAR2,
                            I_MRC_DLGPS_NM IN VARCHAR2,
                            I_MRC_TNO IN VARCHAR2,
                            I_MRC_ZIP IN VARCHAR2,
                            I_MRC_ADR IN VARCHAR2,
                            I_MRC_DTL_ADR IN VARCHAR2,
                            I_PPRN2 IN VARCHAR2,
                            I_CREATED_AT IN DATE,
                            I_UPDATED_AT IN DATE,
                            O_ID OUT NUMBER) AS
    V_YMD   VARCHAR2(6);
    V_SEQ   NUMBER(38);
    V_ID    NUMBER(38);
  BEGIN

      V_YMD := TO_CHAR(SYSDATE, 'yymmdd');

    BEGIN
      SELECT
        /*+ INDEX_DESC( APPROVAL_LOGS APPROVAL_LOGS_PK ) */
        NVL(SEQ, 0) + 1
      INTO V_SEQ
      FROM APPROVAL_LOGS
      WHERE YMD = V_YMD
      AND ROWNUM = 1;
    EXCEPTION
      WHEN no_data_found THEN
        V_SEQ := 1;
    END;

    V_ID := TO_NUMBER(V_YMD||TO_CHAR(V_SEQ,'FM0000000000'));


    INSERT INTO APPROVAL_LOGS
    (
      ID,
      YMD,
      SEQ,
      TYPE_CD,
      HDR_C,
      TSK_DV_C,
      ETXT_SNRC_SN,
      TRS_DT ,
      TRS_T,
      RSP_C,
      PPRN1,
      CARD_NO,
      APR_DT,
      APR_T,
      APR_NO,
      APR_AM,
      APR_CAN_YN,
      APR_TS,
      APR_CAN_DTM,
      MRC_NO,
      MRC_NM,
      BZR_NO,
      MRC_DLGPS_NM,
      MRC_TNO,
      MRC_ZIP,
      MRC_ADR,
      MRC_DTL_ADR,
      PPRN2,
      CREATED_AT,
      UPDATED_AT
    )
    VALUES
    (
      V_ID,
      V_YMD,
      V_SEQ,
      I_TYPE_CD,
      I_HDR_C,
      I_TSK_DV_C,
      I_ETXT_SNRC_SN,
      I_TRS_DT ,
      I_TRS_T,
      I_RSP_C,
      I_PPRN1,
      I_CARD_NO,
      I_APR_DT,
      I_APR_T,
      I_APR_NO,
      I_APR_AM,
      I_APR_CAN_YN,
      I_APR_TS,
      I_APR_CAN_DTM,
      I_MRC_NO,
      I_MRC_NM,
      I_BZR_NO,
      I_MRC_DLGPS_NM,
      I_MRC_TNO,
      I_MRC_ZIP,
      I_MRC_ADR,
      I_MRC_DTL_ADR,
      I_PPRN2,
      I_CREATED_AT,
      I_UPDATED_AT
    );

    O_ID := V_ID;
  END INSERT_APPROVAL;

END LOG_PKG;
        SQL


        execute(sql);

      end
    end
  end
end

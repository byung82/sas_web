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
    V_YMD           VARCHAR2(6);
    V_SEQ           NUMBER(38);
    V_ID            NUMBER(38);
    V_AMT           NUMBER(38);
    V_ST_KEY        VARCHAR2(255);
    V_STORE_CARD    STORE_CARDS%ROWTYPE;
    V_STORE         STORES%ROWTYPE;
  BEGIN

    V_YMD := TO_CHAR(SYSDATE, 'yymmdd');
    V_ST_KEY := SYS_GUID();

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

    SELECT
      *
    INTO V_STORE
    FROM STORES
    WHERE BUSINESS_NO = I_BZR_NO;

    SELECT
      *
    INTO V_STORE_CARD
    FROM STORE_CARDS
    WHERE CARD_NO = I_CARD_NO;


    V_ID := TO_NUMBER(V_YMD||TO_CHAR(V_SEQ,'FM0000000000'));

    V_AMT := TO_NUMBER(I_APR_AM);

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

    MERGE INTO STORE_LIMIT_MSTS TT
    USING
    (
      SELECT
        a.*, ROWNUM RN
      FROM APPROVAL_LOGS a
      WHERE ID = V_ID
    ) ST
    ON (
      TT.YMD=ST.YMD
      AND TT.BUSINESS_NO = ST.BZR_NO
      AND TT.CARD_NO = ST.CARD_NO
    )
    WHEN MATCHED THEN -- UPDATE
        UPDATE SET
          "SAVE" = NVL("SAVE", 0) + DECODE(ST.apr_can_yn, 'Y', V_AMT, 0),
          USED = NVL("USED", 0) + DECODE(ST.apr_can_yn, 'N', V_AMT, 0),
          BALANCE = NVL(BALANCE,0) + DECODE(ST.apr_can_yn, 'Y', V_AMT, 0) - DECODE(ST.apr_can_yn, 'N', V_AMT, 0),
          ST_KEY = V_ST_KEY,
          UPDATED_AT = SYSDATE - 9/24
    WHEN NOT MATCHED THEN
      INSERT
      (
        ID,
        YMD,
        SEQ,
        BUSINESS_NO,
        STORE_ID,
        STORE_CARD_ID,
        CARD_NO,
        SAVE,
        USED,
        WITHDRAW,
        BALANCE,
        ST_KEY,
        CREATED_AT,
        UPDATED_AT
      )
      VALUES
      (
        (
          SELECT
            /*+ INDEX_DESC(STORE_LIMIT_MSTS STORE_LIMIT_MSTS_PK) */
            TO_NUMBER(ST.YMD||TO_CHAR(NVL(MAX(SEQ), 0) + ST.RN,'FM0000000000'))
          FROM STORE_LIMIT_MSTS
          WHERE YMD = ST.YMD
          AND ROWNUM = 1
        ),
        ST.YMD,
        (
          SELECT
            /*+ INDEX_DESC(STORE_LIMIT_MSTS STORE_LIMIT_MSTS_PK) */
            NVL(MAX(SEQ), 0) + ST.RN
          FROM STORE_LIMIT_MSTS
          WHERE YMD = ST.YMD
          AND ROWNUM = 1
        ),
        I_BZR_NO,
        V_STORE.ID,
        V_STORE_CARD.ID,
        I_CARD_NO,
        DECODE(I_APR_CAN_YN, 'Y', V_AMT, 'N', 0),
        DECODE(I_APR_CAN_YN, 'Y', 0, 'N', V_AMT),
        0,
        V_AMT,
        V_ST_KEY,
        SYSDATE - 9/24,
        SYSDATE - 9/24
      );

      INSERT INTO STORE_LIMIT_DETS
      (
        "ID",
        YMD,
        SEQ,
        BUSINESS_NO,
        USER_SEQ,
        APPROVAL_LOG_ID,
        LIMIT_LOG_ID,
        STORE_ID,
        STORE_LIMIT_MST_ID,
        STORE_CARD_ID,
        CARD_NO,
        STATUS_CD,
        AMT,
        BALANCE,
        CREATED_AT,
        UPDATED_AT
      )
      SELECT
        (
          SELECT
            /*+ INDEX_DESC(STORE_LIMIT_DETS STORE_LIMIT_DETS_PK) */
            TO_NUMBER(V_YMD||TO_CHAR(NVL(MAX(SEQ), 0) + ROWNUM(),'FM0000000000'))
          FROM STORE_LIMIT_DETS
          WHERE YMD = V_YMD
          AND ROWNUM = 1
        ),
        V_YMD,
        (
          SELECT
            /*+ INDEX_DESC(STORE_LIMIT_DETS STORE_LIMIT_DETS_PK) */
            NVL(MAX(SEQ), 0) + ROWNUM()
          FROM STORE_LIMIT_DETS
          WHERE YMD = V_YMD
          AND ROWNUM = 1
        ),
        a.BUSINESS_NO,
        V_STORE_CARD.USER_SEQ,
        V_ID,
        NULL,
        V_STORE.ID,
        a.ID,
        V_STORE_CARD.ID,
        V_STORE_CARD.CARD_NO,
        DECODE(I_APR_CAN_YN, 'Y', 'LS003', 'N', 'LS002'),
        V_AMT,
        V_STORE_CARD.LIMIT_AMT,
        SYSDATE - 9/24,
        SYSDATE - 9/24
      FROM STORE_LIMIT_MSTS a
      WHERE ST_KEY = V_ST_KEY;


      UPDATE STORE_CARDS
      SET LIMIT_AMT = LIMIT_AMT + DECODE(I_APR_CAN_YN, 'Y', V_AMT, 'N', V_AMT * -1)
      WHERE ID = STORE_CARDS.ID;

  END INSERT_APPROVAL;

END LOG_PKG;
        SQL


        execute(sql);

      end
    end
  end
end

class CreateStoreCardPkg < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        sql = <<-SQL
create or replace PACKAGE STORE_CARD_PKG AS

  PROCEDURE INSERT_STORE_CARD(I_BUSINESS_NO IN VARCHAR2,
                              I_CARD_NO IN VARCHAR2);

/* TODO enter package declarations (types, exceptions, methods etc) here */

END STORE_CARD_PKG;
        SQL

        execute(sql)

        sql = <<-SQL
create or replace PACKAGE BODY STORE_CARD_PKG AS

PROCEDURE INSERT_STORE_CARD(I_BUSINESS_NO IN VARCHAR2,
                              I_CARD_NO IN VARCHAR2) AS
  V_STORE_ID      NUMBER(38);
  V_YMD           VARCHAR2(6);
  V_SEQ           NUMBER;
  V_COUNT         INTEGER;

BEGIN

  V_YMD := TO_CHAR(SYSDATE, 'yymmdd');

  BEGIN
    SELECT
      /*+ INDEX_DESC( STORE_CARDS STORE_CARDS_PK ) */
      NVL(SEQ, 0) + 1
    INTO V_SEQ
    FROM STORE_CARDS
    WHERE YMD = V_YMD
    AND ROWNUM = 1;
  EXCEPTION
    WHEN no_data_found THEN
      V_SEQ := 1;
  END;

  SELECT
    ID
  INTO V_STORE_ID
  FROM STORES
  WHERE BUSINESS_NO = I_BUSINESS_NO;

  SELECT
    COUNT(*)
    INTO V_COUNT
  FROM STORE_CARDS
  WHERE CARD_NO = I_CARD_NO;

  IF V_COUNT > 0 THEN
    RETURN;
  END IF;

  INSERT INTO STORE_CARDS
  (
    ID,
    YMD,
    SEQ,
    STORE_ID,
    BUSINESS_NO,
    PHONE_NO,
    CARD_NO,
    LIMIT_AMT,
    LOST_YN,
    CREATED_AT,
    UPDATED_AT
  )
  VALUES
  (
    TO_NUMBER(V_YMD||TO_CHAR(V_SEQ,'FM0000000000')),
    V_YMD,
    V_SEQ,
    V_STORE_ID,
    I_BUSINESS_NO,
    ' ',
    I_CARD_NO,
    0,
    'N',
    SYSDATE - 9/24,
    SYSDATE - 9/24
  );


END INSERT_STORE_CARD;

END STORE_CARD_PKG;
        SQL


        execute(sql);

      end
    end
  end
end

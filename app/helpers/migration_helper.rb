module MigrationHelper
  def default_trigger_name(table_name)
    "#{table_name.to_s[0,table_name_length-4]}_pkt".upcase
  end

  def default_primary_constraint(table_name)
    "#{table_name.to_s[0,table_name_length-4]}_pk".upcase
  end

  def create_trigger(table_name)
    query = <<-SQL
CREATE OR REPLACE TRIGGER #{default_trigger_name(table_name).gsub(/"/, '')}
BEFORE INSERT ON #{quote_table_name(table_name)} FOR EACH ROW
BEGIN
  IF inserting THEN
    IF :new."YMD" IS NULL THEN
      SELECT TO_CHAR(SYSDATE,'YYMMDD') INTO :new."YMD" FROM DUAL;
    END IF;

    IF :new."SEQ" IS NULL THEN
      SELECT
        /*+ INDEX_DESC(#{quote_table_name(table_name).gsub(/"/, '')}, #{default_primary_constraint(table_name).gsub(/"/, '')}) */
        NVL(MAX(SEQ), 0) + 1
      INTO :new."SEQ"
      FROM #{quote_table_name(table_name)}
      WHERE YMD = :new."YMD"
      AND ROWNUM = 1;
    END IF;

    IF :new."ID" IS NULL THEN
      SELECT TO_NUMBER(:new."YMD"||TO_CHAR(:new."SEQ",'FM0000000000')) INTO :new."ID" FROM dual;
    END IF;
  END IF;
END;
    SQL
    query
  end

  def change_primary_key(table_name)
    query = <<-SQL
      ALTER TABLE #{quote_table_name(table_name)}
      ADD CONSTRAINT #{default_primary_constraint(table_name)} PRIMARY KEY (ID)
    SQL

    query
  end
end

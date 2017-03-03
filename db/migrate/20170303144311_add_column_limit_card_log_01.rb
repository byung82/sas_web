class AddColumnLimitCardLog01 < ActiveRecord::Migration
  def change
    add_column :limit_card_logs, :acc_amt, :string, limit: 12, default: '0000000000'
    add_column :limit_card_logs, :card_amt, :string, limit: 12, default: '0000000000'

    reversible do |dir|
      dir.up do
        execute('COMMENT ON COLUMN "LIMIT_CARD_LOGS"."ACC_AMT" IS \'통장잔고\'')
        execute('COMMENT ON COLUMN "LIMIT_CARD_LOGS"."CARD_AMT" IS \'카드기한도\'')
      end
    end
  end
end

class AddColumnLimitRequestAmt2 < ActiveRecord::Migration
  def change
    add_column :limit_requests, :save_amt, :integer, default: 0

    reversible do |dir|
      dir.up do
        execute('COMMENT ON COLUMN "LIMIT_REQUESTS"."SAVE_AMT" IS \'적립 요청 금액\'')
      end
    end
  end
end

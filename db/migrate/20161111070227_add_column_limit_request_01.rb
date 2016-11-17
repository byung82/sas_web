class AddColumnLimitRequest01 < ActiveRecord::Migration
  def change
    add_column :limit_requests, :seq_no, :string, limit: 50
    add_column :limit_requests, :deposit_yn, :boolean, default: true

    add_index :limit_requests, :seq_no, name: :limit_requests_idx_09
    add_index :limit_requests, :deposit_yn, name: :limit_requests_idx_10

    reversible do |dir|
      dir.up do
        execute('COMMENT ON COLUMN "LIMIT_REQUESTS"."SEQ_NO" IS \'고유번호\'')
        execute('COMMENT ON COLUMN "LIMIT_REQUESTS"."DEPOSIT_YN" IS \'입금여부\'')
      end
    end
  end
end

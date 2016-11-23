class CreateAddColumnApprovalSyncYmds < ActiveRecord::Migration
  def change
    add_column :approval_logs, :sync_ymd, :string, limit: 8


    reversible do |dir|
      dir.up do
        execute('COMMENT ON COLUMN "APPROVAL_LOGS"."SYNC_YMD" IS \'카드 동기화 예정일\'')
      end
    end
  end
end

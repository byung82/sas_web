class AddColumnLimitRequestSyncYn < ActiveRecord::Migration
  def change
    add_column :limit_requests, :sync_yn, :boolean, default: 'N'


    reversible do |dir|
      dir.up do
        execute('COMMENT ON COLUMN "LIMIT_REQUESTS"."SYNC_YN" IS \'카드 한도 체크 여부\'')
      end
    end
  end
end

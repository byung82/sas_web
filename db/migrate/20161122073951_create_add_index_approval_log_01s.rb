class CreateAddIndexApprovalLog01s < ActiveRecord::Migration
  def change
    add_index :approval_logs, :sync_ymd, name: :approval_logs_idx_04
  end
end

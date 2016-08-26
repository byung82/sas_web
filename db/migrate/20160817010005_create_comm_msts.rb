include MigrationHelper

class CreateCommMsts < ActiveRecord::Migration
  def change
    create_table :comm_msts, id: false, comment: '공통코드 마스터' do |t|
      t.integer :id, comment: '고유키'

      t.string :ymd, limit: 6, comment: '년월일'

      t.integer :seq, comment: '순번'

      t.string :code, limit: 20, comment: '코드'

      t.string :explan, limit: 100, comment: '설명'

      t.boolean :deleted_yn, default: 'N', comment: '사용여부'

      t.belongs_to :created, comment: '생성자'

      t.belongs_to :updated, comment: '수정자'

      t.belongs_to :deleted, comment: '삭제자'

      t.timestamps null: false

      t.datetime :deleted_at, comment: '삭제일'
    end

    add_index :comm_msts, [:ymd, :seq], unique: true, name: :comm_msts_idx_01

    add_index :comm_msts, :code, unique: true, name: :comm_msts_idx_02

    add_index :comm_msts, :deleted_yn, name: :comm_msts_idx_03

    add_index :comm_msts, :created_id, name: :comm_msts_idx_05

    add_index :comm_msts, :updated_id, name: :comm_msts_idx_06

    add_index :comm_msts, :deleted_id, name: :comm_msts_idx_07

    reversible do |dir|
      dir.up do
        execute(change_primary_key(:comm_msts))

        execute(create_trigger(:comm_msts))
      end
    end
  end
end

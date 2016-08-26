include MigrationHelper

class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels, id: false, comment: '레벨 TREE 구조' do |t|
      t.integer :id, null: false, comment: 'FK키'

      t.string :ymd, limit: 8, comment: '년월일'

      t.integer :seq, comment: '순번'

      t.string  :levelable_type, limit: 100

      t.integer :levelable_id

      t.string :lvl, limit: 3000

      t.timestamps
    end

    add_index :levels, [:ymd, :seq], unique: true, name: :levels_idx_01
    add_index :levels, [:levelable_type, :levelable_id], name: :levels_idx_02
    add_index :levels, :lvl, name: :levels_idx_03

    reversible do |dir|
      dir.up do
        execute(change_primary_key(:levels))

        execute(create_trigger(:levels))
      end
    end

  end
end

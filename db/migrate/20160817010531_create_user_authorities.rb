include MigrationHelper
class CreateUserAuthorities < ActiveRecord::Migration
  def change
    create_table :user_authorities, id: false do |t|
      t.integer :id, null: false, comment: '고유키'

      t.string :ymd, limit: 8, comment: '년월일'

      t.integer :seq, comment: '순번'

      t.belongs_to :user, comment: 'USER FK'

      t.belongs_to :authority, comment: 'AUTHORITY FK'

      t.boolean :deleted_yn, default: false, comment: '삭제여부'

      t.timestamps null: false
    end


    reversible do |dir|
      dir.up do
        execute(change_primary_key(:user_authorities))

        execute(create_trigger(:user_authorities))

        u = User.find_by(email: 'system@kminlove.com')
        u.authorities << Authority.find_by(code: 'R000')

        u = User.find_by(email: 'admin@kminlove.com')
        u.authorities << Authority.find_by(code: 'R999')
      end
    end

  end
end
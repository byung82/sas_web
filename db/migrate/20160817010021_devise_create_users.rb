include MigrationHelper

class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: false, comment: '회원 테이블' do |t|
      ## Database authenticatable
      t.integer  :id,        null: false, comment: 'USERS PK'

      t.string   :ymd,       limit: 8, comment: '년월일'

      t.integer  :seq,       comment: '순번'

      t.string :login,  null: false, limit:50, comment:'login아이디'
      t.string :email,              null: false, default: '', comment: '이메일주소'
      t.string :encrypted_password, null: false, default: '', comment: '암호화된 비밀번호'
      t.string :phone_no,           null: false, limit: 20, comment: '연락처'
      t.string :username,           null: false, limit: 100, comment: '이름'
      t.string :nickname,           null: true,  limit: 100, comment: '닉네임'

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      t.string   :status_cd, limit: 20, comment: '회원 상태 코드'

      t.belongs_to :created, comment: '생성자'
      t.belongs_to :updated, comment: '수정자'

      t.timestamps null: false
    end
    add_index :users, [:ymd, :seq],          unique: true, name: :users_idx_01
    add_index :users, :email,                unique: true, name: :users_idx_02
    add_index :users, :reset_password_token, unique: true, name: :users_idx_03
    add_index :users, :confirmation_token,   unique: true, name: :users_idx_04
    add_index :users, :unlock_token,         unique: true, name: :users_idx_05
    add_index :users, :created_id,           name: :users_idx_06
    add_index :users, :updated_id,           name: :users_idx_07

    reversible do |dir|
      dir.up do
        execute(change_primary_key(:users))

        execute(create_trigger(:users))

        execute <<-SQL
          INSERT INTO USERS(id, ymd, seq, login, email, encrypted_password, phone_no, username, nickname, created_id, updated_id, created_at, updated_at)
          VALUES (
            1601010000000001, '160101', '1', 'system',  'system@kminlove.com','1111','00000000001', '시스템', '시스템',
            1601010000000001, 1601010000000001, SYSDATE, SYSDATE
          )
        SQL

        u = User.find_by(id: 1601010000000001)


        User.create!(email: 'admin@kminlove.com', username: '관리자',
                     login: 'admin',
                     password: 'admin00!@#',
                     phone_no: '00000000000',
                     created:u, updated: u)

        User.create!(email: 'byung82@kminlove.com',
                     login:'byung82',
                     username: '김병석',
                     password: 'ehfl22#00',
                     phone_no: '01030425915',
                     created:u, updated: u)


        User.create!(email: 'humoney@111.com',
                     login:'humoney',
                     username: '김병석',
                     password: 'humoney00!@#',
                     phone_no: '01000001111',
                     created:u, updated: u)
      end
    end
  end
end

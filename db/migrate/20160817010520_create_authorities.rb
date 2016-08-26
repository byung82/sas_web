include MigrationHelper

class CreateAuthorities < ActiveRecord::Migration
  def change
    create_table :authorities, id: false, comment: '권한 테이블' do |t|
      t.integer :id, null: false, comment: '고유키'
      t.string :ymd, limit: 8, comment: '년월일'
      t.integer :seq, comment: '순번'
      t.string :code, limit: 20, comment: '권한코드'
      t.string :explan, limit: 100, comment: '코드 설명'

      t.belongs_to :created, comment: '생성자'
      t.belongs_to :updated, comment: '수정자'

      t.timestamps null: false
    end

    add_index :authorities, [:ymd, :seq], unique: true, name: :authorities_idx_01

    add_index :authorities, :code, unique: true, name: :authorities_idx_02

    add_index :authorities, :created_id, name: :authorities_idx_03

    add_index :authorities, :updated_id, name: :authorities_idx_04

    reversible do |dir|
      dir.up do
        execute(change_primary_key(:authorities))

        execute(create_trigger(:authorities))

        u = User.find_by(id: 1601010000000001)

        Authority.create!(code: 'R999', explan: '관리자', created: u, updated: u)
        Authority.create!(code: 'R900', explan: '중간관리자', created: u, updated: u)
        Authority.create!(code: 'R200', explan: '가맹점', created: u, updated: u)
        Authority.create!(code: 'R000', explan: '시스템', created: u, updated: u)
      end
    end
  end
end

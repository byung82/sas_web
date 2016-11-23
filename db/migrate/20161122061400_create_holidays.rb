class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.string        :ymd, limit: 8, comment: '년월일'

      t.string        :description, comment: '설명'

      t.boolean       :deleted_yn, default: 'N', comment: '삭제여부 Y: 삭제 N: 미삭제'

      t.belongs_to    :created, comment: '생성자'

      t.belongs_to    :updated, comment: '수정자'

      t.belongs_to    :deleted, comment: '삭제자'

      t.datetime      :created_at, null: false, comment: '생성일'

      t.datetime      :updated_at, null: false, comment: '수정일'

      t.datetime      :deleted_at, null: true, comment: '삭제일'
    end
  end
end

class AddColumnStoreCallbackUrl < ActiveRecord::Migration
  def change
    add_column :stores, :callback, :string, limit: 1000
    add_column :stores, :class_name, :string


    reversible do |dir|
      dir.up do
        execute('COMMENT ON COLUMN "STORES"."CALLBACK" IS \'동기화 URL 주소\'')
        execute('COMMENT ON COLUMN "STORES"."CLASS_NAME" IS \'콜백 클래스 명\'')
      end
    end
  end
end

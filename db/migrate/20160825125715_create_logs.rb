class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs, id: false, comment: 'API 통신로그' do |t|
      t.integer  :id,        null: false, comment: 'VERSIONS PK'

      t.string   :ymd,       limit: 8, comment: '년월일'

      t.integer  :seq,       comment: '순번'

      t.string   :login,     comment: '로그인 아이디'

      t.string   :method,    comment: 'HTTP METHOD'

      t.string   :controller, comment: 'controller class name'

      t.text     :parameters, comment: 'HTTP PARAMS'

      t.timestamps null: false
    end

    reversible do |dir|
      dir.up do
        execute(change_primary_key(:logs))

        execute(create_trigger(:logs))
      end
    end
  end
end


# include MigrationHelper
#
# class CreateErrorTracks < ActiveRecord::Migration
#   def change
#     create_table :error_tracks, id: false, comment: '오류 목록' do |t|
#       t.integer  :id,        null: false, comment: 'VERSIONS PK'
#       t.string   :ymd,       limit: 8, comment: '년월일'
#       t.integer  :seq,       comment: '순번'
#
#       t.text     :message
#       t.text     :trace
#       t.text     :parameter
#       t.timestamps null: false
#     end
#
#     reversible do |dir|
#       dir.up do
#         execute(change_primary_key(:error_tracks))
#
#         execute(create_trigger(:error_tracks))
#       end
#     end
#   end
# end

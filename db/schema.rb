# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160928045232) do

  create_table "approval_logs", force: :cascade do |t|
    t.string   "ymd",          limit: 8,                                                comment: "???"
    t.integer  "seq",                      precision: 38,                               comment: "??"
    t.string   "type_cd",                                 default: "P002",              comment: "P001:????, P002: ????"
    t.string   "hdr_c",        limit: 4,                                                comment: "??LEN"
    t.string   "tsk_dv_c",     limit: 4,                                                comment: "??????"
    t.string   "etxt_snrc_sn", limit: 10,                                               comment: "?????????"
    t.string   "trs_dt",       limit: 8,                                                comment: "????"
    t.string   "trs_t",        limit: 6,                                                comment: "????"
    t.string   "rsp_c",        limit: 4,                                                comment: "???? 0000:??, 0010:????, 0011:?????, 0012:???, 0041:?????, 0099:????"
    t.string   "pprn1",        limit: 18,                                               comment: "??1"
    t.string   "card_no",      limit: 16,                                               comment: "????"
    t.string   "apr_dt",       limit: 8,                                                comment: "????"
    t.string   "apr_t",        limit: 6,                                                comment: "????"
    t.string   "apr_no",       limit: 8,                                                comment: "???? ???, ???? ????"
    t.string   "apr_am",       limit: 18,                                               comment: "????"
    t.boolean  "apr_can_yn",   limit: nil,                                              comment: "?????? Y:????"
    t.string   "apr_ts",       limit: 17,                                               comment: "?????? ???? ?????? yyyymmddhh24missSSS"
    t.string   "apr_can_dtm",  limit: 14,                                               comment: "?????? ???? ?????? yyyymmddhh24miss"
    t.string   "mrc_no",       limit: 12,                                               comment: "?????"
    t.string   "mrc_nm",       limit: 50,                                               comment: "????"
    t.string   "bzr_no",       limit: 10,                                               comment: "?????"
    t.string   "mrc_dlgps_nm", limit: 12,                                               comment: "???????"
    t.string   "mrc_tno",      limit: 16,                                               comment: "???????"
    t.string   "mrc_zip",      limit: 6,                                                comment: "???????"
    t.string   "mrc_adr",      limit: 70,                                               comment: "?????"
    t.string   "mrc_dtl_adr",  limit: 70,                                               comment: "???????"
    t.string   "pprn2",        limit: 16,                                               comment: "??2"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
  end

  add_index "approval_logs", ["card_no"], name: "approval_logs_idx_03"
  add_index "approval_logs", ["type_cd"], name: "approval_logs_idx_02"
  add_index "approval_logs", ["ymd", "seq"], name: "approval_logs_idx_01", unique: true

  create_table "authorities", comment: "?? ???", force: :cascade do |t|
    t.string   "ymd",        limit: 8,                               comment: "???"
    t.integer  "seq",                    precision: 38,              comment: "??"
    t.string   "code",       limit: 20,                              comment: "????"
    t.string   "explan",     limit: 100,                             comment: "?? ??"
    t.integer  "created_id", limit: nil,                             comment: "???"
    t.integer  "updated_id", limit: nil,                             comment: "???"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "authorities", ["code"], name: "authorities_idx_02", unique: true
  add_index "authorities", ["created_id"], name: "authorities_idx_03"
  add_index "authorities", ["updated_id"], name: "authorities_idx_04"
  add_index "authorities", ["ymd", "seq"], name: "authorities_idx_01", unique: true

  add_primary_key_trigger "authorities"

  create_table "card_syncs", comment: "?????? ?????? ????????? ?????????", id: false, force: :cascade do |t|
    t.integer  "id",          limit: nil,                            comment: "?????????"
    t.string   "ymd",         limit: 6,                              comment: "?????????"
    t.integer  "seq",                     precision: 38,             comment: "??????"
    t.string   "business_no", limit: 10,                             comment: "????????? ????????????"
    t.string   "card_no",     limit: 16,                             comment: "????????????"
    t.integer  "balance",                 precision: 38, default: 0, comment: "??????"
    t.datetime "sync_at",                                            comment: "????????? ??????"
  end

  create_table "comm_dets", comment: "???? ??", force: :cascade do |t|
    t.string   "ymd",         limit: 8,                                                         comment: "???"
    t.integer  "seq",                     precision: 38,                                        comment: "??"
    t.integer  "comm_mst_id", limit: nil,                                                       comment: "comm_dets FK"
    t.string   "code",        limit: 20,                                                        comment: "??"
    t.string   "idty",        limit: 20,                                                        comment: "idty"
    t.string   "explan",      limit: 100,                                                       comment: "??"
    t.boolean  "deleted_yn",  limit: nil,                          default: false,              comment: "????"
    t.string   "sval1",                                                                         comment: "???? 1"
    t.string   "sval2",                                                                         comment: "???? 2"
    t.string   "sval3",                                                                         comment: "???? 3"
    t.string   "sval4",                                                                         comment: "???? 3"
    t.string   "sval5",                                                                         comment: "???? 5"
    t.string   "sval6",                                                                         comment: "???? 6"
    t.string   "sval7",                                                                         comment: "???? 7"
    t.string   "sval8",                                                                         comment: "???? 8"
    t.string   "sval9",                                                                         comment: "???? 9"
    t.string   "sval10",                                                                        comment: "???? 10"
    t.decimal  "val1",                    precision: 10, scale: 3,                              comment: "??? 1"
    t.decimal  "val2",                    precision: 10, scale: 3,                              comment: "??? 2"
    t.decimal  "val3",                    precision: 10, scale: 3,                              comment: "??? 3"
    t.decimal  "val4",                    precision: 10, scale: 3,                              comment: "??? 4"
    t.decimal  "val5",                    precision: 10, scale: 3,                              comment: "??? 5"
    t.decimal  "val6",                    precision: 10, scale: 3,                              comment: "??? 6"
    t.decimal  "val7",                    precision: 10, scale: 3,                              comment: "??? 7"
    t.decimal  "val8",                    precision: 10, scale: 3,                              comment: "??? 8"
    t.decimal  "val9",                    precision: 10, scale: 3,                              comment: "??? 9"
    t.decimal  "val10",                   precision: 10, scale: 3,                              comment: "??? 10"
    t.integer  "created_id",  limit: nil,                                                       comment: "???"
    t.integer  "updated_id",  limit: nil,                                                       comment: "???"
    t.integer  "deleted_id",  limit: nil,                                                       comment: "???"
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.datetime "deleted_at",                                                                    comment: "???"
  end

  add_index "comm_dets", ["code", "idty"], name: "comm_dets_idx_02", unique: true
  add_index "comm_dets", ["comm_mst_id"], name: "comm_dets_idx_04"
  add_index "comm_dets", ["created_id"], name: "comm_dets_idx_05"
  add_index "comm_dets", ["deleted_id"], name: "comm_dets_idx_07"
  add_index "comm_dets", ["deleted_yn"], name: "comm_dets_idx_03"
  add_index "comm_dets", ["updated_id"], name: "comm_dets_idx_06"
  add_index "comm_dets", ["ymd", "seq"], name: "comm_dets_idx_01", unique: true

  add_primary_key_trigger "comm_dets"

  create_table "comm_msts", comment: "???? ???", force: :cascade do |t|
    t.string   "ymd",        limit: 6,                                               comment: "???"
    t.integer  "seq",                    precision: 38,                              comment: "??"
    t.string   "code",       limit: 20,                                              comment: "??"
    t.string   "explan",     limit: 100,                                             comment: "??"
    t.boolean  "deleted_yn", limit: nil,                default: false,              comment: "????"
    t.integer  "created_id", limit: nil,                                             comment: "???"
    t.integer  "updated_id", limit: nil,                                             comment: "???"
    t.integer  "deleted_id", limit: nil,                                             comment: "???"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.datetime "deleted_at",                                                         comment: "???"
  end

  add_index "comm_msts", ["code"], name: "comm_msts_idx_02", unique: true
  add_index "comm_msts", ["created_id"], name: "comm_msts_idx_05"
  add_index "comm_msts", ["deleted_id"], name: "comm_msts_idx_07"
  add_index "comm_msts", ["deleted_yn"], name: "comm_msts_idx_03"
  add_index "comm_msts", ["updated_id"], name: "comm_msts_idx_06"
  add_index "comm_msts", ["ymd", "seq"], name: "comm_msts_idx_01", unique: true

  add_primary_key_trigger "comm_msts"

  create_table "error_tracks", comment: "?? ??", force: :cascade do |t|
    t.string   "ymd",        limit: 8,                             comment: "???"
    t.integer  "seq",                  precision: 38,              comment: "??"
    t.text     "message"
    t.text     "trace"
    t.text     "parameter"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_primary_key_trigger "error_tracks"

  create_table "levels", comment: "?? TREE ??", force: :cascade do |t|
    t.string   "ymd",            limit: 8,                   comment: "???"
    t.integer  "seq",                         precision: 38, comment: "??"
    t.string   "levelable_type", limit: 100
    t.integer  "levelable_id",   limit: nil
    t.string   "lvl",            limit: 3000
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "levels", ["levelable_type", "levelable_id"], name: "levels_idx_02"
  add_index "levels", ["lvl"], name: "levels_idx_03"
  add_index "levels", ["ymd", "seq"], name: "levels_idx_01", unique: true

  add_primary_key_trigger "levels"

  create_table "limit_logs", comment: "????/?? ?????", force: :cascade do |t|
    t.string   "ymd",            limit: 8,                                                comment: "???"
    t.integer  "seq",                        precision: 38,                               comment: "??"
    t.string   "type_cd",                                   default: "P002",              comment: "P001:????, P002: ????"
    t.string   "hdr_c",          limit: 4,                                                comment: "??LEN"
    t.string   "tsk_dv_c",       limit: 4,                                                comment: "??????"
    t.string   "etxt_snrc_sn",   limit: 10,                                               comment: "?????????"
    t.string   "trs_dt",         limit: 8,                                                comment: "????"
    t.string   "trs_t",          limit: 6,                                                comment: "????"
    t.string   "rsp_c",          limit: 4,                                                comment: "???? 0000:??, 0010:????, 0011:?????, 0012:???, 0041:?????, 0099:????"
    t.string   "pprn1",          limit: 18,                                               comment: "??1"
    t.string   "bzr_no",         limit: 10,                                               comment: "???????"
    t.boolean  "dlng_dv_c",      limit: nil,                                              comment: "??????"
    t.string   "crtl_pge_no",    limit: 3,                                                comment: "???????"
    t.string   "wo_pge_n",       limit: 3,                                                comment: "???????"
    t.text     "card",                                                                    comment: "????"
    t.string   "no2_trs_flr_cn", limit: 112,                                              comment: "??"
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
  end

  add_index "limit_logs", ["bzr_no"], name: "limit_logs_idx_03"
  add_index "limit_logs", ["type_cd"], name: "limit_logs_idx_02"
  add_index "limit_logs", ["ymd", "seq"], name: "limit_logs_idx_01", unique: true

  create_table "limit_requests", comment: "???? ???", force: :cascade do |t|
    t.string   "ymd",           limit: 6,                                               comment: "???"
    t.integer  "seq",                       precision: 38,                              comment: "??"
    t.string   "type_cd",       limit: 20,                                              comment: "????"
    t.string   "limit_cd",      limit: 20,                                              comment: "??/??"
    t.string   "business_no",   limit: 10,                                              comment: "???????"
    t.string   "card_no",       limit: 16,                                              comment: "????"
    t.integer  "amt",                       precision: 38,                              comment: "?? ??"
    t.boolean  "send_yn",       limit: nil,                default: false,              comment: "?? ??"
    t.boolean  "error_yn",      limit: nil,                default: false,              comment: "???? ?? ??"
    t.string   "code",          limit: 4,                                               comment: "????"
    t.integer  "store_id",      limit: nil
    t.integer  "store_card_id", limit: nil
    t.integer  "created_id",    limit: nil
    t.integer  "updated_id",    limit: nil
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
  end

  add_index "limit_requests", ["business_no"], name: "limit_requests_idx_04"
  add_index "limit_requests", ["created_id"], name: "limit_requests_idx_05"
  add_index "limit_requests", ["error_yn"], name: "limit_requests_idx_03"
  add_index "limit_requests", ["send_yn"], name: "limit_requests_idx_02"
  add_index "limit_requests", ["store_card_id"], name: "limit_requests_idx_08"
  add_index "limit_requests", ["store_id"], name: "limit_requests_idx_07"
  add_index "limit_requests", ["updated_id"], name: "limit_requests_idx_06"
  add_index "limit_requests", ["ymd", "seq"], name: "limit_requests_idx_01", unique: true

  add_primary_key_trigger "limit_requests"

  create_table "logs", comment: "API ????", force: :cascade do |t|
    t.string   "ymd",        limit: 8,                             comment: "???"
    t.integer  "seq",                  precision: 38,              comment: "??"
    t.string   "login",                                            comment: "??? ???"
    t.string   "method",                                           comment: "HTTP METHOD"
    t.string   "controller",                                       comment: "controller class name"
    t.text     "parameters",                                       comment: "HTTP PARAMS"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_primary_key_trigger "logs"

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", limit: nil,                null: false
    t.integer  "application_id",    limit: nil,                null: false
    t.string   "token",                                        null: false
    t.integer  "expires_in",                    precision: 38, null: false
    t.text     "redirect_uri",                                 null: false
    t.datetime "created_at",                                   null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "i_oauth_access_grants_token", unique: true

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id",      limit: nil
    t.integer  "application_id",         limit: nil
    t.string   "token",                  limit: 1000,                             null: false
    t.string   "refresh_token",          limit: 1000
    t.integer  "expires_in",                          precision: 38
    t.datetime "revoked_at"
    t.datetime "created_at",                                                      null: false
    t.string   "scopes"
    t.string   "previous_refresh_token", limit: 1000,                default: ""
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "i_oau_acc_tok_ref_tok", unique: true
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "i_oau_acc_tok_res_own_id"
  add_index "oauth_access_tokens", ["token"], name: "i_oauth_access_tokens_token", unique: true

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                                  null: false
    t.string   "uid",                                   null: false
    t.string   "secret",                                null: false
    t.text     "redirect_uri",                          null: false
    t.string   "scopes",                   default: "", null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "owner_id",     limit: nil
    t.string   "owner_type"
  end

  add_index "oauth_applications", ["owner_id", "owner_type"], name: "i_oau_app_own_id_own_typ"
  add_index "oauth_applications", ["uid"], name: "i_oauth_applications_uid", unique: true

  create_table "store_cards", comment: "??? ???? ", force: :cascade do |t|
    t.string   "ymd",         limit: 8,                                               comment: "???"
    t.integer  "seq",                     precision: 38,                              comment: "??"
    t.string   "user_seq",    limit: 100,                                             comment: "????? ???"
    t.integer  "store_id",    limit: nil
    t.string   "phone_no",    limit: 20,                                              comment: "??????"
    t.string   "business_no", limit: 10,                                              comment: "??????"
    t.string   "card_no",     limit: 16,                                              comment: "????"
    t.integer  "limit_amt",               precision: 38,                              comment: "??"
    t.boolean  "lost_yn",     limit: nil,                default: false,              comment: "????"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.integer  "sync_amt",                precision: 38, default: 0
  end

  add_index "store_cards", ["card_no"], name: "store_cards_idx_03"
  add_index "store_cards", ["phone_no"], name: "store_cards_idx_02"
  add_index "store_cards", ["ymd", "seq"], name: "store_cards_idx_01", unique: true

  create_table "store_limit_dets", comment: "?? ?? ?? ??", force: :cascade do |t|
    t.string   "ymd",                limit: 8,                               comment: "???"
    t.integer  "seq",                            precision: 38,              comment: "??"
    t.string   "business_no",                                                comment: "???????"
    t.string   "user_seq",           limit: 100,                             comment: "??? ?? FK"
    t.integer  "approval_log_id",    limit: nil,                             comment: "???? FK"
    t.integer  "limit_log_id",       limit: nil,                             comment: "?? FK"
    t.integer  "store_id",           limit: nil,                             comment: "???"
    t.integer  "store_limit_mst_id", limit: nil
    t.integer  "store_card_id",      limit: nil,                             comment: "??? FK"
    t.string   "card_no",            limit: 16,                              comment: "????"
    t.string   "status_cd",          limit: 20,                              comment: "????"
    t.integer  "amt",                            precision: 38,              comment: "??/??/?? ??"
    t.integer  "balance",                        precision: 38,              comment: "??"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "store_limit_dets", ["business_no"], name: "store_limit_dets_idx_06"
  add_index "store_limit_dets", ["card_no"], name: "store_limit_dets_idx_04"
  add_index "store_limit_dets", ["status_cd"], name: "store_limit_dets_idx_05"
  add_index "store_limit_dets", ["store_card_id"], name: "store_limit_dets_idx_03"
  add_index "store_limit_dets", ["store_id"], name: "store_limit_msts_idx_07"
  add_index "store_limit_dets", ["store_limit_mst_id"], name: "store_limit_dets_idx_02"
  add_index "store_limit_dets", ["user_seq"], name: "store_limit_msts_idx_08"
  add_index "store_limit_dets", ["ymd", "seq"], name: "store_limit_dets_idx_01", unique: true

  create_table "store_limit_msts", comment: "?? ?? ?? ??", force: :cascade do |t|
    t.string   "ymd",           limit: 8,                               comment: "???"
    t.integer  "seq",                       precision: 38,              comment: "??"
    t.string   "business_no",                                           comment: "???????"
    t.integer  "store_id",      limit: nil,                             comment: "???"
    t.integer  "store_card_id", limit: nil,                null: false, comment: "??? FK"
    t.string   "card_no",       limit: 16,                 null: false, comment: "????"
    t.integer  "save",                      precision: 38,              comment: "? ?? ??"
    t.integer  "used",                      precision: 38,              comment: "? ?? ??"
    t.integer  "withdraw",                  precision: 38,              comment: "? ?? ??"
    t.integer  "balance",                   precision: 38,              comment: "??"
    t.string   "st_key",                                                comment: "???? ?? ?"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "store_limit_msts", ["business_no"], name: "store_limit_msts_idx_04"
  add_index "store_limit_msts", ["card_no"], name: "store_limit_msts_idx_03"
  add_index "store_limit_msts", ["st_key"], name: "store_limit_msts_idx_06"
  add_index "store_limit_msts", ["store_card_id"], name: "store_limit_msts_idx_02"
  add_index "store_limit_msts", ["store_id"], name: "store_limit_msts_idx_05"
  add_index "store_limit_msts", ["ymd", "seq"], name: "store_limit_msts_idx_01", unique: true

  create_table "store_users", comment: "??? ??", force: :cascade do |t|
    t.string   "ymd",        limit: 8,                               comment: "???"
    t.integer  "seq",                    precision: 38,              comment: "??"
    t.integer  "user_id",    limit: nil
    t.integer  "store_id",   limit: nil
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "store_users", ["store_id"], name: "store_users_idx_03"
  add_index "store_users", ["user_id"], name: "store_users_idx_02"
  add_index "store_users", ["ymd", "seq"], name: "store_users_idx_01", unique: true

  add_primary_key_trigger "store_users"

  create_table "stores", comment: "???", force: :cascade do |t|
    t.integer  "parent_id",   limit: nil,                                               comment: "?? ID"
    t.string   "ymd",         limit: 8,                                                 comment: "???"
    t.integer  "seq",                     precision: 38,                                comment: "??"
    t.string   "store_name",  limit: 100,                                               comment: "??? ??"
    t.string   "business_no", limit: 10,                                                comment: "???????"
    t.string   "phone_no",    limit: 20,                                                comment: "????"
    t.string   "email",                                                                 comment: "?????\n"
    t.string   "ceo_name",    limit: 100,                                               comment: "????"
    t.string   "zone_code",   limit: 5,                                                 comment: "????"
    t.string   "addr1",       limit: 150,                                               comment: "??"
    t.string   "addr2",       limit: 100,                                               comment: "????"
    t.float    "lat",                                                                   comment: "??"
    t.float    "lng",                                                                   comment: "??"
    t.integer  "created_id",  limit: nil,                                               comment: "???"
    t.integer  "updated_id",  limit: nil,                                               comment: "???"
    t.integer  "deleted_id",  limit: nil,                                               comment: "???"
    t.integer  "manager_id",  limit: nil,                                               comment: "???"
    t.string   "status_cd",   limit: 20,                 default: "SS001",              comment: "????"
    t.boolean  "deleted_yn",  limit: nil,                default: false,                comment: "????"
    t.datetime "created_at",                                               null: false, comment: "?? ???"
    t.datetime "updated_at",                                               null: false, comment: "?? ???"
    t.datetime "deleted_at",                                                            comment: "???"
    t.datetime "sync_at",                                                               comment: "?????"
    t.boolean  "sync_yn",     limit: nil,                default: true,                 comment: "??? ?? ??\n"
    t.datetime "send_at"
  end

  add_index "stores", ["business_no"], name: "stores_idx_04", unique: true
  add_index "stores", ["created_id"], name: "stores_idx_05"
  add_index "stores", ["deleted_id"], name: "stores_idx_09"
  add_index "stores", ["manager_id"], name: "stores_idx_07"
  add_index "stores", ["parent_id"], name: "stores_idx_08"
  add_index "stores", ["status_cd"], name: "stores_idx_02"
  add_index "stores", ["store_name"], name: "stores_idx_03"
  add_index "stores", ["sync_at"], name: "stores_idx_10"
  add_index "stores", ["sync_yn", "send_at"], name: "stores_idx_11"
  add_index "stores", ["updated_id"], name: "stores_idx_06"
  add_index "stores", ["ymd", "seq"], name: "stores_idx_01", unique: true

  add_primary_key_trigger "stores"

  create_table "user_authorities", force: :cascade do |t|
    t.string   "ymd",          limit: 8,                                               comment: "???"
    t.integer  "seq",                      precision: 38,                              comment: "??"
    t.integer  "user_id",      limit: nil,                                             comment: "USER FK"
    t.integer  "authority_id", limit: nil,                                             comment: "AUTHORITY FK"
    t.boolean  "deleted_yn",   limit: nil,                default: false,              comment: "????"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  add_primary_key_trigger "user_authorities"

  create_table "users", comment: "?? ???", force: :cascade do |t|
    t.string   "ymd",                    limit: 8,                                            comment: "???"
    t.integer  "seq",                                precision: 38,                           comment: "??"
    t.string   "login",                  limit: 50,                              null: false, comment: "login???"
    t.string   "email",                                             default: "", null: false, comment: "?????"
    t.string   "encrypted_password",                                default: "", null: false, comment: "???? ????"
    t.string   "phone_no",               limit: 20,                              null: false, comment: "???"
    t.string   "username",               limit: 100,                             null: false, comment: "??"
    t.string   "nickname",               limit: 100,                                          comment: "???"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      precision: 38, default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                    precision: 38, default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "status_cd",              limit: 20,                                           comment: "?? ?? ??"
    t.integer  "created_id",             limit: nil,                                          comment: "???"
    t.integer  "updated_id",             limit: nil,                                          comment: "???"
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
  end

  add_index "users", ["confirmation_token"], name: "users_idx_04", unique: true
  add_index "users", ["created_id"], name: "users_idx_06"
  add_index "users", ["email"], name: "users_idx_02", unique: true
  add_index "users", ["reset_password_token"], name: "users_idx_03", unique: true
  add_index "users", ["unlock_token"], name: "users_idx_05", unique: true
  add_index "users", ["updated_id"], name: "users_idx_07"
  add_index "users", ["ymd", "seq"], name: "users_idx_01", unique: true

  add_primary_key_trigger "users"

  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
end

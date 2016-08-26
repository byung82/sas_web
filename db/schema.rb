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

ActiveRecord::Schema.define(version: 20160825105403) do

  create_table "authorities", comment: "권한 테이블", force: :cascade do |t|
    t.string   "ymd",        limit: 8,                               comment: "년월일"
    t.integer  "seq",                    precision: 38,              comment: "순번"
    t.string   "code",       limit: 20,                              comment: "권한코드"
    t.string   "explan",     limit: 100,                             comment: "코드 설명"
    t.integer  "created_id", limit: nil,                             comment: "생성자"
    t.integer  "updated_id", limit: nil,                             comment: "수정자"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "authorities", ["code"], name: "authorities_idx_02", unique: true
  add_index "authorities", ["created_id"], name: "authorities_idx_03"
  add_index "authorities", ["updated_id"], name: "authorities_idx_04"
  add_index "authorities", ["ymd", "seq"], name: "authorities_idx_01", unique: true

  add_primary_key_trigger "authorities"

  create_table "comm_dets", comment: "공통코드 상세", force: :cascade do |t|
    t.string   "ymd",         limit: 8,                                                         comment: "년월일"
    t.integer  "seq",                     precision: 38,                                        comment: "순번"
    t.integer  "comm_mst_id", limit: nil,                                                       comment: "comm_dets FK"
    t.string   "code",        limit: 20,                                                        comment: "코드"
    t.string   "idty",        limit: 20,                                                        comment: "idty"
    t.string   "explan",      limit: 100,                                                       comment: "설명"
    t.boolean  "deleted_yn",  limit: nil,                          default: false,              comment: "사용여부"
    t.string   "sval1",                                                                         comment: "문자열값 1"
    t.string   "sval2",                                                                         comment: "문자열값 2"
    t.string   "sval3",                                                                         comment: "문자열값 3"
    t.string   "sval4",                                                                         comment: "문자열값 3"
    t.string   "sval5",                                                                         comment: "문자열값 5"
    t.string   "sval6",                                                                         comment: "문자열값 6"
    t.string   "sval7",                                                                         comment: "문자열값 7"
    t.string   "sval8",                                                                         comment: "문자열값 8"
    t.string   "sval9",                                                                         comment: "문자열값 9"
    t.string   "sval10",                                                                        comment: "문자열값 10"
    t.decimal  "val1",                    precision: 10, scale: 3,                              comment: "숫자값 1"
    t.decimal  "val2",                    precision: 10, scale: 3,                              comment: "숫자값 2"
    t.decimal  "val3",                    precision: 10, scale: 3,                              comment: "숫자값 3"
    t.decimal  "val4",                    precision: 10, scale: 3,                              comment: "숫자값 4"
    t.decimal  "val5",                    precision: 10, scale: 3,                              comment: "숫자값 5"
    t.decimal  "val6",                    precision: 10, scale: 3,                              comment: "숫자값 6"
    t.decimal  "val7",                    precision: 10, scale: 3,                              comment: "숫자값 7"
    t.decimal  "val8",                    precision: 10, scale: 3,                              comment: "숫자값 8"
    t.decimal  "val9",                    precision: 10, scale: 3,                              comment: "숫자값 9"
    t.decimal  "val10",                   precision: 10, scale: 3,                              comment: "숫자값 10"
    t.integer  "created_id",  limit: nil,                                                       comment: "생성자"
    t.integer  "updated_id",  limit: nil,                                                       comment: "수정자"
    t.integer  "deleted_id",  limit: nil,                                                       comment: "삭제자"
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.datetime "deleted_at",                                                                    comment: "삭제일"
  end

  add_index "comm_dets", ["code", "idty"], name: "comm_dets_idx_02", unique: true
  add_index "comm_dets", ["comm_mst_id"], name: "comm_dets_idx_04"
  add_index "comm_dets", ["created_id"], name: "comm_dets_idx_05"
  add_index "comm_dets", ["deleted_id"], name: "comm_dets_idx_07"
  add_index "comm_dets", ["deleted_yn"], name: "comm_dets_idx_03"
  add_index "comm_dets", ["updated_id"], name: "comm_dets_idx_06"
  add_index "comm_dets", ["ymd", "seq"], name: "comm_dets_idx_01", unique: true

  add_primary_key_trigger "comm_dets"

  create_table "comm_msts", comment: "공통코드 마스터", force: :cascade do |t|
    t.string   "ymd",        limit: 6,                                               comment: "년월일"
    t.integer  "seq",                    precision: 38,                              comment: "순번"
    t.string   "code",       limit: 20,                                              comment: "코드"
    t.string   "explan",     limit: 100,                                             comment: "설명"
    t.boolean  "deleted_yn", limit: nil,                default: false,              comment: "사용여부"
    t.integer  "created_id", limit: nil,                                             comment: "생성자"
    t.integer  "updated_id", limit: nil,                                             comment: "수정자"
    t.integer  "deleted_id", limit: nil,                                             comment: "삭제자"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.datetime "deleted_at",                                                         comment: "삭제일"
  end

  add_index "comm_msts", ["code"], name: "comm_msts_idx_02", unique: true
  add_index "comm_msts", ["created_id"], name: "comm_msts_idx_05"
  add_index "comm_msts", ["deleted_id"], name: "comm_msts_idx_07"
  add_index "comm_msts", ["deleted_yn"], name: "comm_msts_idx_03"
  add_index "comm_msts", ["updated_id"], name: "comm_msts_idx_06"
  add_index "comm_msts", ["ymd", "seq"], name: "comm_msts_idx_01", unique: true

  add_primary_key_trigger "comm_msts"

  create_table "levels", comment: "레벨 TREE 구조", force: :cascade do |t|
    t.string   "ymd",            limit: 8,                   comment: "년월일"
    t.integer  "seq",                         precision: 38, comment: "순번"
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
    t.string   "token",                                                          null: false
    t.string   "refresh_token"
    t.integer  "expires_in",                         precision: 38
    t.datetime "revoked_at"
    t.datetime "created_at",                                                     null: false
    t.string   "scopes"
    t.string   "previous_refresh_token",                            default: "", null: false
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "i_oau_acc_tok_ref_tok", unique: true
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "i_oau_acc_tok_res_own_id"
  add_index "oauth_access_tokens", ["token"], name: "i_oauth_access_tokens_token", unique: true

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "oauth_applications", ["uid"], name: "i_oauth_applications_uid", unique: true

  create_table "req_card_limits", force: :cascade do |t|
    t.string   "business_no", limit: 10
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "seq_tab", id: false, force: :cascade do |t|
    t.string  "gubun", limit: 100,                null: false
    t.integer "seq",   limit: 12,  precision: 12, null: false
    t.string  "ymd",   limit: 6,                  null: false
  end

  create_table "store_cards", comment: "가맹점 카드정보 ", force: :cascade do |t|
    t.string   "ymd",        limit: 8,                                               comment: "년월일"
    t.integer  "seq",                    precision: 38,                              comment: "순번"
    t.integer  "store_id",   limit: nil
    t.string   "phone_no",   limit: 20,                                              comment: "휴대전화번호"
    t.string   "card_no",    limit: 16,                                              comment: "카드번호"
    t.integer  "limit_amt",              precision: 38,                              comment: "한도"
    t.boolean  "lost_yn",    limit: nil,                default: false,              comment: "분실여부"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

  add_index "store_cards", ["ymd", "seq"], name: "store_cards_idx_01", unique: true

  create_table "store_limit_dets", id: false, force: :cascade do |t|
    t.string "column1", limit: 20
  end

  create_table "store_limit_msts", comment: "카드 한도 사용 내역", force: :cascade do |t|
    t.string   "ymd",           limit: 8,                               comment: "년월일"
    t.integer  "seq",                       precision: 38,              comment: "순번"
    t.string   "business_no",                                           comment: "사업자등록번호"
    t.integer  "store_id",      limit: nil,                             comment: "가맹점"
    t.integer  "store_card_id", limit: nil,                null: false, comment: "사용자 FK"
    t.string   "card_no",       limit: 16,                 null: false, comment: "카드번호"
    t.integer  "save",                      precision: 38,              comment: "총 적립 금액"
    t.integer  "used",                      precision: 38,              comment: "총 사용 금액"
    t.integer  "withdraw",                  precision: 38,              comment: "총 출금 금액"
    t.integer  "balance",                   precision: 38,              comment: "잔액"
    t.string   "st_key",                                                comment: "업데이트 체크 키"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "store_limit_msts", ["business_no"], name: "store_limit_msts_idx_04"
  add_index "store_limit_msts", ["card_no"], name: "store_limit_msts_idx_03"
  add_index "store_limit_msts", ["st_key"], name: "store_limit_msts_idx_06"
  add_index "store_limit_msts", ["store_card_id"], name: "store_limit_msts_idx_02"
  add_index "store_limit_msts", ["store_id"], name: "store_limit_msts_idx_05"
  add_index "store_limit_msts", ["ymd", "seq"], name: "store_limit_msts_idx_01", unique: true

  create_table "store_limt_dets", comment: "카드 한도 사용 내역", force: :cascade do |t|
    t.string   "ymd",                limit: 8,                               comment: "년월일"
    t.integer  "seq",                            precision: 38,              comment: "순번"
    t.string   "business_no",                                                comment: "사업자등록번호"
    t.integer  "approval_log_id",    limit: nil,                             comment: "통신로그 FK"
    t.integer  "store_id",           limit: nil,                             comment: "가맹점"
    t.integer  "store_limit_mst_id", limit: nil
    t.integer  "store_card_id",      limit: nil,                             comment: "사용자 FK"
    t.string   "card_no",            limit: 16,                              comment: "카드번호"
    t.string   "status_cd",          limit: 20,                              comment: "상태코드"
    t.integer  "amt",                            precision: 38,              comment: "적립/사용/출금 금액"
    t.integer  "balance",                        precision: 38,              comment: "잔액"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "store_limt_dets", ["business_no"], name: "store_limt_dets_idx_06"
  add_index "store_limt_dets", ["card_no"], name: "store_limt_dets_idx_04"
  add_index "store_limt_dets", ["status_cd"], name: "store_limt_dets_idx_05"
  add_index "store_limt_dets", ["store_card_id"], name: "store_limt_dets_idx_03"
  add_index "store_limt_dets", ["store_id"], name: "store_limit_msts_idx_07"
  add_index "store_limt_dets", ["store_limit_mst_id"], name: "store_limt_dets_idx_02"
  add_index "store_limt_dets", ["ymd", "seq"], name: "store_limt_dets_idx_01", unique: true

  create_table "store_users", comment: "가맹점 회원", force: :cascade do |t|
    t.string   "ymd",        limit: 8,                               comment: "년월일"
    t.integer  "seq",                    precision: 38,              comment: "순번"
    t.integer  "user_id",    limit: nil
    t.integer  "store_id",   limit: nil
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "store_users", ["store_id"], name: "store_users_idx_03"
  add_index "store_users", ["user_id"], name: "store_users_idx_02"
  add_index "store_users", ["ymd", "seq"], name: "store_users_idx_01", unique: true

  add_primary_key_trigger "store_users"

  create_table "stores", comment: "가맹점", force: :cascade do |t|
    t.integer  "parent_id",   limit: nil,                                               comment: "상위 ID"
    t.string   "ymd",         limit: 8,                                                 comment: "년월일"
    t.integer  "seq",                     precision: 38,                                comment: "순번"
    t.string   "store_name",  limit: 100,                                               comment: "가맹점 정보"
    t.string   "business_no", limit: 10,                                                comment: "사업자등록번호"
    t.string   "phone_no",    limit: 20,                                                comment: "전화번호"
    t.string   "email",                                                                 comment: "이메일주소\n"
    t.string   "ceo_name",    limit: 100,                                               comment: "대표자명"
    t.string   "zone_code",   limit: 5,                                                 comment: "우편번호"
    t.string   "addr1",       limit: 150,                                               comment: "주소"
    t.string   "addr2",       limit: 100,                                               comment: "상세주소"
    t.float    "lat",                                                                   comment: "위도"
    t.float    "lng",                                                                   comment: "경도"
    t.integer  "created_id",  limit: nil,                                               comment: "생성자"
    t.integer  "updated_id",  limit: nil,                                               comment: "수정자"
    t.integer  "deleted_id",  limit: nil,                                               comment: "삭제자"
    t.integer  "manager_id",  limit: nil,                                               comment: "담당자"
    t.string   "status_cd",   limit: 20,                 default: "SS001",              comment: "상태코드"
    t.boolean  "deleted_yn",  limit: nil,                default: false,                comment: "삭제여부"
    t.datetime "created_at",                                               null: false, comment: "수정 삭제일"
    t.datetime "updated_at",                                               null: false, comment: "수정 삭제일"
    t.datetime "deleted_at",                                                            comment: "삭제일"
  end

  add_index "stores", ["business_no"], name: "stores_idx_04", unique: true
  add_index "stores", ["created_id"], name: "stores_idx_05"
  add_index "stores", ["deleted_id"], name: "stores_idx_09"
  add_index "stores", ["manager_id"], name: "stores_idx_07"
  add_index "stores", ["parent_id"], name: "stores_idx_08"
  add_index "stores", ["status_cd"], name: "stores_idx_02"
  add_index "stores", ["store_name"], name: "stores_idx_03"
  add_index "stores", ["updated_id"], name: "stores_idx_06"
  add_index "stores", ["ymd", "seq"], name: "stores_idx_01", unique: true

  add_primary_key_trigger "stores"

  create_table "temp_store_limit_msts", comment: "카드 한도 사용 내역", id: false, force: :cascade do |t|
    t.integer  "id",            limit: nil,                null: false, comment: "고유키"
    t.string   "ymd",           limit: 8,                               comment: "년월일"
    t.integer  "seq",                       precision: 38,              comment: "순번"
    t.string   "business_no",                                           comment: "사업자등록번호"
    t.integer  "store_id",      limit: nil,                             comment: "가맹점"
    t.integer  "store_card_id", limit: nil,                null: false, comment: "사용자 FK"
    t.string   "card_no",       limit: 16,                 null: false, comment: "카드번호"
    t.integer  "save",                      precision: 38,              comment: "총 적립 금액"
    t.integer  "used",                      precision: 38,              comment: "총 사용 금액"
    t.integer  "withdraw",                  precision: 38,              comment: "총 출금 금액"
    t.integer  "balance",                   precision: 38,              comment: "잔액"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "user_authorities", force: :cascade do |t|
    t.string   "ymd",          limit: 8,                                               comment: "년월일"
    t.integer  "seq",                      precision: 38,                              comment: "순번"
    t.integer  "user_id",      limit: nil,                                             comment: "USER FK"
    t.integer  "authority_id", limit: nil,                                             comment: "AUTHORITY FK"
    t.boolean  "deleted_yn",   limit: nil,                default: false,              comment: "삭제여부"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  add_primary_key_trigger "user_authorities"

  create_table "users", comment: "회원 테이블", force: :cascade do |t|
    t.string   "ymd",                    limit: 8,                                            comment: "년월일"
    t.integer  "seq",                                precision: 38,                           comment: "순번"
    t.string   "login",                  limit: 50,                              null: false, comment: "login아이디"
    t.string   "email",                                             default: "", null: false, comment: "이메일주소"
    t.string   "encrypted_password",                                default: "", null: false, comment: "암호화된 비밀번호"
    t.string   "phone_no",               limit: 20,                              null: false, comment: "연락처"
    t.string   "username",               limit: 100,                             null: false, comment: "이름"
    t.string   "nickname",               limit: 100,                                          comment: "닉네임"
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
    t.string   "status_cd",              limit: 20,                                           comment: "회원 상태 코드"
    t.integer  "created_id",             limit: nil,                                          comment: "생성자"
    t.integer  "updated_id",             limit: nil,                                          comment: "수정자"
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

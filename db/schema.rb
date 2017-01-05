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

ActiveRecord::Schema.define(version: 20170103233741) do

  create_table "approval_logs", force: :cascade do |t|
    t.string   "ymd",          limit: 8,                                                comment: "년월일"
    t.integer  "seq",                      precision: 38,                               comment: "순번"
    t.string   "type_cd",                                 default: "P002",              comment: "P001:전송패킷, P002: 수신패킷"
    t.string   "hdr_c",        limit: 4,                                                comment: "패킷LEN"
    t.string   "tsk_dv_c",     limit: 4,                                                comment: "전문구분코드"
    t.string   "etxt_snrc_sn", limit: 10,                                               comment: "전문송수신일련번호"
    t.string   "trs_dt",       limit: 8,                                                comment: "전송일자"
    t.string   "trs_t",        limit: 6,                                                comment: "전송시간"
    t.string   "rsp_c",        limit: 4,                                                comment: "응답코드 0000:정상, 0010:거래중복, 0011:원거래없음, 0012:기취소, 0041:미존재카드, 0099:기타오류"
    t.string   "pprn1",        limit: 18,                                               comment: "예비1"
    t.string   "card_no",      limit: 16,                                               comment: "카드번호"
    t.string   "apr_dt",       limit: 8,                                                comment: "승인일자"
    t.string   "apr_t",        limit: 6,                                                comment: "승인시각"
    t.string   "apr_no",       limit: 8,                                                comment: "승인번호 취소시, 원거래의 승인번호"
    t.string   "apr_am",       limit: 18,                                               comment: "승인시각"
    t.boolean  "apr_can_yn",   limit: nil,                                              comment: "승인취소여부 Y:취소완료"
    t.string   "apr_ts",       limit: 17,                                               comment: "승인상세일시 삼성카드 승인처리일시 yyyymmddhh24missSSS"
    t.string   "apr_can_dtm",  limit: 14,                                               comment: "승인취소일시 삼성카드 취소처리일시 yyyymmddhh24miss"
    t.string   "mrc_no",       limit: 12,                                               comment: "가맹점번호"
    t.string   "mrc_nm",       limit: 50,                                               comment: "가맹점명"
    t.string   "bzr_no",       limit: 10,                                               comment: "사업자번호"
    t.string   "mrc_dlgps_nm", limit: 12,                                               comment: "가맹점대표자명"
    t.string   "mrc_tno",      limit: 16,                                               comment: "가맹점전화번호"
    t.string   "mrc_zip",      limit: 6,                                                comment: "가맹점우편번호"
    t.string   "mrc_adr",      limit: 70,                                               comment: "가맹점주소"
    t.string   "mrc_dtl_adr",  limit: 70,                                               comment: "가맹점상세주소"
    t.string   "pprn2",        limit: 16,                                               comment: "예비2"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.string   "sync_ymd",     limit: 10,                                               comment: "카드 동기화 예정일"
  end

  add_index "approval_logs", ["card_no"], name: "approval_logs_idx_03"
  add_index "approval_logs", ["sync_ymd"], name: "approval_logs_idx_04"
  add_index "approval_logs", ["type_cd"], name: "approval_logs_idx_02"
  add_index "approval_logs", ["ymd", "seq"], name: "approval_logs_idx_01", unique: true

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

  create_table "card_syncs", comment: "������ ������ ��������� ���������", id: false, force: :cascade do |t|
    t.integer  "id",          limit: nil,                            comment: "���������"
    t.string   "ymd",         limit: 6,                              comment: "���������"
    t.integer  "seq",                     precision: 38,             comment: "������"
    t.string   "business_no", limit: 10,                             comment: "��������� ������������"
    t.string   "card_no",     limit: 16,                             comment: "������������"
    t.integer  "balance",                 precision: 38, default: 0, comment: "������"
    t.datetime "sync_at",                                            comment: "��������� ������"
  end

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

  create_table "error_tracks", comment: "오류 목록", force: :cascade do |t|
    t.string   "ymd",        limit: 8,                             comment: "년월일"
    t.integer  "seq",                  precision: 38,              comment: "순번"
    t.text     "message"
    t.text     "trace"
    t.text     "parameter"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_primary_key_trigger "error_tracks"

  create_table "holidays", force: :cascade do |t|
    t.string   "ymd",         limit: 8,                                comment: "년월일"
    t.string   "description",                                          comment: "설명"
    t.boolean  "deleted_yn",  limit: nil, default: false,              comment: "삭제여부 Y: 삭제 N: 미삭제"
    t.integer  "created_id",  limit: nil,                              comment: "생성자"
    t.integer  "updated_id",  limit: nil,                              comment: "수정자"
    t.integer  "deleted_id",  limit: nil,                              comment: "삭제자"
    t.datetime "created_at",                              null: false, comment: "생성일"
    t.datetime "updated_at",                              null: false, comment: "수정일"
    t.datetime "deleted_at",                                           comment: "삭제일"
  end

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

  create_table "limit_card_logs", comment: "카드한도 조호 로그 테이블", force: :cascade do |t|
    t.string   "ymd",          limit: 8,                                               comment: "년월일"
    t.integer  "seq",                     precision: 38,                               comment: "순번"
    t.string   "type_cd",                                default: "P002",              comment: "P001:전송패킷, P002: 수신패킷"
    t.string   "hdr_c",        limit: 4,                                               comment: "패킷LEN"
    t.string   "tsk_dv_c",     limit: 4,                                               comment: "전문구분코드"
    t.string   "etxt_snrc_sn", limit: 10,                                              comment: "전문송수신일련번호"
    t.string   "trs_dt",       limit: 8,                                               comment: "전송일자"
    t.string   "trs_t",        limit: 6,                                               comment: "전송시간"
    t.string   "rsp_c",        limit: 4,                                               comment: "응답코드 0000:정상, 0010:거래중복, 0011:원거래없음, 0012:기취소, 0041:미존재카드, 0099:기타오류"
    t.string   "pprn1",        limit: 18,                                              comment: "예비1"
    t.string   "card_no",      limit: 16,                                              comment: "카드번호"
    t.string   "amt",                                                                  comment: "한도금액"
    t.string   "pprn2",                                                                comment: "예비"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  add_index "limit_card_logs", ["card_no"], name: "limit_card_logs_idx_03"
  add_index "limit_card_logs", ["type_cd"], name: "limit_card_logs_idx_02"
  add_index "limit_card_logs", ["ymd", "seq"], name: "limit_card_logs_idx_01", unique: true

  create_table "limit_logs", comment: "한도승인/차감 로그테이블", force: :cascade do |t|
    t.string   "ymd",            limit: 8,                                                comment: "년월일"
    t.integer  "seq",                        precision: 38,                               comment: "순번"
    t.string   "type_cd",                                   default: "P002",              comment: "P001:전송패킷, P002: 수신패킷"
    t.string   "hdr_c",          limit: 4,                                                comment: "패킷LEN"
    t.string   "tsk_dv_c",       limit: 4,                                                comment: "전문구분코드"
    t.string   "etxt_snrc_sn",   limit: 10,                                               comment: "전문송수신일련번호"
    t.string   "trs_dt",         limit: 8,                                                comment: "전송일자"
    t.string   "trs_t",          limit: 6,                                                comment: "전송시간"
    t.string   "rsp_c",          limit: 4,                                                comment: "응답코드 0000:정상, 0010:거래중복, 0011:원거래없음, 0012:기취소, 0041:미존재카드, 0099:기타오류"
    t.string   "pprn1",          limit: 18,                                               comment: "예비1"
    t.string   "bzr_no",         limit: 10,                                               comment: "사업자등록번호"
    t.boolean  "dlng_dv_c",      limit: nil,                                              comment: "거래구분코드"
    t.string   "crtl_pge_no",    limit: 3,                                                comment: "현제페이지번호"
    t.string   "wo_pge_n",       limit: 3,                                                comment: "전체페이지번호"
    t.text     "card",                                                                    comment: "카드번호"
    t.string   "no2_trs_flr_cn", limit: 112,                                              comment: "예비"
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
  end

  add_index "limit_logs", ["bzr_no"], name: "limit_logs_idx_03"
  add_index "limit_logs", ["type_cd"], name: "limit_logs_idx_02"
  add_index "limit_logs", ["ymd", "seq"], name: "limit_logs_idx_01", unique: true

  create_table "limit_requests", comment: "한도요청 테이블", force: :cascade do |t|
    t.string   "ymd",           limit: 6,                                               comment: "년월일"
    t.integer  "seq",                       precision: 38,                              comment: "순번"
    t.string   "type_cd",       limit: 20,                                              comment: "충전방식"
    t.string   "limit_cd",      limit: 20,                                              comment: "상향/햐양"
    t.string   "business_no",   limit: 10,                                              comment: "사업자등록번호"
    t.string   "card_no",       limit: 16,                                              comment: "카드번호"
    t.integer  "amt",                       precision: 38,                              comment: "충전 금액"
    t.boolean  "send_yn",       limit: nil,                default: false,              comment: "전송 여부"
    t.boolean  "error_yn",      limit: nil,                default: false,              comment: "한도증액 오류 여부"
    t.string   "code",          limit: 4,                                               comment: "상태코드"
    t.integer  "store_id",      limit: nil
    t.integer  "store_card_id", limit: nil
    t.integer  "created_id",    limit: nil
    t.integer  "updated_id",    limit: nil
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.string   "seq_no",        limit: 50,                                              comment: "고유번호"
    t.boolean  "deposit_yn",    limit: nil,                default: true,               comment: "입금여부"
    t.integer  "save_amt",                  precision: 38, default: 0,                  comment: "적립 요청 금액"
    t.boolean  "sync_yn",       limit: nil,                default: false,              comment: "카드 한도 체크 여부"
  end

  add_index "limit_requests", ["business_no"], name: "limit_requests_idx_04"
  add_index "limit_requests", ["created_id"], name: "limit_requests_idx_05"
  add_index "limit_requests", ["deposit_yn"], name: "limit_requests_idx_10"
  add_index "limit_requests", ["error_yn"], name: "limit_requests_idx_03"
  add_index "limit_requests", ["send_yn"], name: "limit_requests_idx_02"
  add_index "limit_requests", ["seq_no"], name: "limit_requests_idx_09"
  add_index "limit_requests", ["store_card_id"], name: "limit_requests_idx_08"
  add_index "limit_requests", ["store_id"], name: "limit_requests_idx_07"
  add_index "limit_requests", ["updated_id"], name: "limit_requests_idx_06"
  add_index "limit_requests", ["ymd", "seq"], name: "limit_requests_idx_01", unique: true

  add_primary_key_trigger "limit_requests"

  create_table "logs", comment: "API 통신로그", force: :cascade do |t|
    t.string   "ymd",        limit: 8,                             comment: "년월일"
    t.integer  "seq",                  precision: 38,              comment: "순번"
    t.string   "login",                                            comment: "로그인 아이디"
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

  create_table "store_cards", comment: "가맹점 카드정보 ", force: :cascade do |t|
    t.string   "ymd",         limit: 8,                                               comment: "년월일"
    t.integer  "seq",                     precision: 38,                              comment: "순번"
    t.string   "user_seq",    limit: 100,                                             comment: "카드사용자 고유키"
    t.integer  "store_id",    limit: nil
    t.string   "phone_no",    limit: 20,                                              comment: "휴대전화번호"
    t.string   "business_no", limit: 10,                                              comment: "휴대전화번호"
    t.string   "card_no",     limit: 16,                                              comment: "카드번호"
    t.integer  "limit_amt",               precision: 38,                              comment: "한도"
    t.boolean  "lost_yn",     limit: nil,                default: false,              comment: "분실여부"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.integer  "sync_amt",                precision: 38, default: 0
    t.integer  "lookup_amt",              precision: 38, default: 0
  end

  add_index "store_cards", ["card_no"], name: "store_cards_idx_03"
  add_index "store_cards", ["phone_no"], name: "store_cards_idx_02"
  add_index "store_cards", ["ymd", "seq"], name: "store_cards_idx_01", unique: true

  create_table "store_limit_dets", comment: "카드 한도 사용 내역", force: :cascade do |t|
    t.string   "ymd",                limit: 8,                               comment: "년월일"
    t.integer  "seq",                            precision: 38,              comment: "순번"
    t.string   "business_no",                                                comment: "사업자등록번호"
    t.string   "user_seq",           limit: 100,                             comment: "무기명 회원 FK"
    t.integer  "approval_log_id",    limit: nil,                             comment: "통신로그 FK"
    t.integer  "limit_log_id",       limit: nil,                             comment: "한도 FK"
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

  add_index "store_limit_dets", ["business_no"], name: "store_limit_dets_idx_06"
  add_index "store_limit_dets", ["card_no"], name: "store_limit_dets_idx_04"
  add_index "store_limit_dets", ["status_cd"], name: "store_limit_dets_idx_05"
  add_index "store_limit_dets", ["store_card_id"], name: "store_limit_dets_idx_03"
  add_index "store_limit_dets", ["store_id"], name: "store_limit_msts_idx_07"
  add_index "store_limit_dets", ["store_limit_mst_id"], name: "store_limit_dets_idx_02"
  add_index "store_limit_dets", ["user_seq"], name: "store_limit_msts_idx_08"
  add_index "store_limit_dets", ["ymd", "seq"], name: "store_limit_dets_idx_01", unique: true

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
    t.datetime "sync_at",                                                               comment: "동기화일시"
    t.boolean  "sync_yn",     limit: nil,                default: true,                 comment: "동기화 사용 여부\n"
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

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



# start_no = 7000000000000001
# end_no = start_no + (250 *4)
#
#
#
# (start_no..end_no).each do |card_no|
#   plsql.store_card_pkg.insert_store_card('TEST000001', card_no.to_s)
#
#   p card_no
# end
#


#  https://vbank.kminlove.com/bank.jsp


req_data = {
    'JobCode': 'V',
    'CompCode': '0006',
    'CompName': '국민사랑정산',
    'CustName': '국민사랑',
    'CustID': '00001',
    'MaxAmount': '',
    'ExpDate': '',
    'SecureCode': '0000',
    'FixedAmountYN': 'N'
}.to_json.encode('EUC-KR', 'UTF-8')


# req_data = {
#     'JobCode': 'B',
#     'CompCode': '0006',
#     'SecureCode': '0000'
# }.to_json.encode('EUC-KR', 'UTF-8')
#
# response = RestClient.post 'https://vbank.kminlove.com/banking.jsp',
#                            {
#                                'REQDATA': req_data
#                            }
# response = response.encode('UTF-8', 'EUC-KR')
#
# response = JSON.parse(response)
#
# p response

# req_data = {
#     'JobCode': 'W',
#     'CompCode': '0006',
#     'SecureCode': '0000',
#     'DestBankCode': '088',
#     'DestAccountNo': '100031098665',
#     'Amount': '1000',
#     'Remark': '가맹점정산'
# }.to_json.encode('EUC-KR', 'UTF-8')
#
# req_data = {
#     'JobCode': 'W',
#     'CompCode': '0006',
#     'SecureCode': '0000',
#     'DestBankCode': '011',
#     'DestAccountNo': '3010121692181',
#     'Amount': '9709',
#     'Remark': '결제대행국민사랑'
# }.to_json.encode('EUC-KR', 'UTF-8')
#
#
# #
# # 변수 REQDATA의 변수값 예
# # {"JobCode":"W", "CompCode":"0000", "DestBankCode":"023", "DestAccountNo":"123456789012", "Amount":"1000", "Remark":"적요내용", "SecureCode":"0000"}
# #
# # JobCode: 출금 업무코드 ("W")
# # CompCode:
# # 업체코드
# # DestBankCode: 출금 상대 은행 코드 (SC제일은행:"023")
# # DestAccountNo: 출금 상대 계좌번호
# # Amount: 출금액
# # Remark: 적요
# # SecureCode: 업체코드, DestBankCode, DestAccountNo, Amount 등을 조합하여 산출한 보안번호 (임시 보안번호:"0000")
#
# response = RestClient.post 'https://vbank.kminlove.com/banking.jsp',
#                            {
#                                'REQDATA': req_data
#                            }
# response = response.encode('UTF-8', 'EUC-KR')
#
# response = JSON.parse(response)
#
# p response
#


# 004	645901-04-308957	58218
# 003	696-011882-04-014	1103803
# 003	281-055986-04-014	1264250
# 088	110287370268	1878309
# 045	9003224910867 	973050
# 011	150100-56-042671	97030
# 023	560-20-153555	829909
# 011	3010121692181 	9709
# 045	9002176520401 	22241
# 003	11914733101019 	1934

items = [
    {
        bank_cd: '004',
        account_no: '645901-04-308957'.gsub(/-/, ''),
        amt: 58218,
        remark: '(주)국민사랑',
    },
    {
        bank_cd: '003',
        account_no: '696-011882-04-014'.gsub(/-/, ''),
        amt: 1103803,
        remark: '(주)국민사랑',
    },
    {
        bank_cd: '003',
        account_no: '281-055986-04-014'.gsub(/-/, ''),
        amt: 1264250,
        remark: '(주)국민사랑',
    },
    {
        bank_cd: '088',
        account_no: '110287370268'.gsub(/-/, ''),
        amt: 1878309,
        remark: '(주)국민사랑',
    },
    {
        bank_cd: '045',
        account_no: '9003224910867'.gsub(/-/, ''),
        amt: 973050,
        remark: '(주)국민사랑',
    },
    {
        bank_cd: '011',
        account_no: '150100-56-042671'.gsub(/-/, ''),
        amt: 97030,
        remark: '(주)국민사랑',
    },
    {
        bank_cd: '023',
        account_no: '560-20-153555'.gsub(/-/, ''),
        amt: 829909,
        remark: '(주)국민사랑',
    },
    {
        bank_cd: '011',
        account_no: '3010121692181'.gsub(/-/, ''),
        amt: 9709,
        remark: '(주)국민사랑',
    },
    {
        bank_cd: '045',
        account_no: '9002176520401'.gsub(/-/, ''),
        amt: 22241,
        remark: '(주)국민사랑',
    },
    {
        bank_cd: '003',
        account_no: '11914733101019'.gsub(/-/, ''),
        amt: 1934,
        remark: '(주)국민사랑',
    },
]

items.each do |item|
  req_data = {
      'JobCode': 'B',
      'CompCode': '0006',
      'SecureCode': '0000'
  }.to_json.encode('EUC-KR', 'UTF-8')

  response = RestClient.post 'https://vbank.kminlove.com/banking.jsp',
                             {
                                 'REQDATA': req_data
                             }
  response = response.encode('UTF-8', 'EUC-KR')

  response = JSON.parse(response)

  p response

  p item[:bank_cd]
  p item[:account_no]
  p item[:amt]
  p item[:remark]

  req_data = {
      'JobCode': 'W',
      'CompCode': '0006',
      'SecureCode': '0000',
      'DestBankCode': item[:bank_cd],
      'DestAccountNo': item[:account_no],
      'Amount': item[:amt].to_s,
      'Remark': item[:remark]
  }.to_json.encode('EUC-KR', 'UTF-8')

  response = RestClient.post 'https://vbank.kminlove.com/banking.jsp',
                             {
                                 'REQDATA': req_data
                             }
  response = response.encode('UTF-8', 'EUC-KR')

  response = JSON.parse(response)

  p response


  #
  # req_data = {
  #     'JobCode': 'W',
  #     'CompCode': '0006',
  #     'SecureCode': '0000',
  #     'DestBankCode': '004',
  #     'DestAccountNo': '80130101583722',
  #     'Amount': '13538',
  #     'Remark': '결제대행국민사랑'
  # }.to_json.encode('EUC-KR', 'UTF-8')
  #
end

# req_data = {
#     'JobCode': 'W',
#     'CompCode': '0006',
#     'SecureCode': '0000',
#     'DestBankCode': '004',
#     'DestAccountNo': '80130101583722',
#     'Amount': '13538',
#     'Remark': '결제대행국민사랑'
# }.to_json.encode('EUC-KR', 'UTF-8')
#
# response = RestClient.post 'https://vbank.kminlove.com/banking.jsp',
#                            {
#                                'REQDATA': req_data
#                            }
# response = response.encode('UTF-8', 'EUC-KR')
#
# response = JSON.parse(response)
#
# p response
#
# req_data = {
#     'JobCode': 'B',
#     'CompCode': '0006',
#     'SecureCode': '0000'
# }.to_json.encode('EUC-KR', 'UTF-8')
#
# response = RestClient.post 'https://vbank.kminlove.com/banking.jsp',
#                            {
#                                'REQDATA': req_data
#                            }
# response = response.encode('UTF-8', 'EUC-KR')
#
# response = JSON.parse(response)
#
# p response


# s = Store.find_or_initialize_by(business_no: '1111')
#
# u = User.new
#
# u.login = 'kiwiworks'
# u.password = 'kiw00!@#'
# u.email = '11@1122.com'
# u.username = '키위윅스'
# u.nickname = '키위윅스'
# u.phone_no = '1111'
# p u.save
# p u.errors
#
# s.users << u
#


# client = OAuth2::Client.new('e07aa0da3969f26d96c968f7a696b6ca234ff7fa9ca5d79e604c053584eddff5',
#                             '48da95f7990cb6239502c222f94883f6d75c4be8a32fbf3b9b73b4d75c81ffcd',
#                             :site => 'https://api-sas.kminlove.com')
#
#
# token = client.password.get_token('humoney', 'humoney00!@#', params: {grant_type: 'password'})
#
# p token

#
# response = token.post('/api/v1/charges',
#                      params:{card_no: '9410852258709300',
#                              business_no: '6818100394',
#                              amt: 500000,
#                              seq_no: '2016111700010'
#                      } )
#
#
# p response.parsed
# begin
#   client = OAuth2::Client.new('749c0bff0ed3615d3befc043311e24a16646f4e656ddd5eb6fb6106741f57a24', '2336bd69779e6d6dda16a99eed81f4f5e16b8560311fcc1dde52b03f753cd189', :site => 'http://localhost:3006')
#
#   token = client.password.get_token('humoney', '11111111', params: {grant_type: 'password'})
#
#   response = token.post('/api/v1/charges', params:{business_no: '6818100394', card_no: '9410852258688700', amt: 1000} )
#
#   p response.parsed
# rescue => e
#   p e
#   p e.response.body
# end
#
# client = OAuth2::Client.new('', '', site: 'https://speed-pay.co.kr')
#
# access = client.password.get_token('nowwed', '11111111')

# ApprovalLog.create!(
#                hdr_c: '0400',
#                tsk_dv_c: '1000',
#                etxt_snrc_sn: '8525247967',
#                trs_dt: '20160825',
#                trs_t: '132357',
#                rsp_c: '    ',
#                pprn1: '                  ',
#                card_no: '9410852258688700',
#                apr_dt: '20160825',
#                apr_t: '132357',
#                apr_no: '50128513',
#                apr_am: '000000000000001000',
#                apr_can_yn: 'N',
#                apr_ts: '12345678901234567',
#                apr_can_dtm: '12345678901234',
#                mrc_no: '            ',
#                mrc_nm: '                                                  ',
#                bzr_no: '          ',
#                mrc_dlgps_nm: '            ',
#                mrc_tno: '                ',
#                mrc_zip: '      ',
#                mrc_adr: '                                                                      ',
#                mrc_dtl_adr: '                                                                      ',
#                pprn2: '                ',
#
# )

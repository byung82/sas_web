class LimitRequest < ActiveRecord::Base

  include ActiveRecord::OracleEnhancedProcedures


  include UserInfo

  belongs_to :store

  belongs_to :store_card


  belongs_to :approval_log

  set_update_method do



    plsql.log_pkg.update_limit_requests(
        i_id: self.id,
        i_limit_log_id: self.limit_log_id,
        i_send_yn: self.send_yn ? 'Y' : 'N',
        i_error_yn: self.error_yn ? 'Y' : 'N',
        i_code: self.code
    )
  end

  def response
    Api::V1::Response::Charge.create(self)
  end




  def limit_log_id
    @limit_log_id
  end

  def limit_log_id=(value)
    @limit_log_id = value
  end
end

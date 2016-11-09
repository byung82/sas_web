class Api::V1::Manager::UsageSerializer < ActiveModel::Serializer
  attributes :id, :amt, :card_no, :usage_store_name, :status_txt, :balance, :approval_no, :approval_at, :canceled_at, :cancel_yn

  def usage_store_name
    object.approval_log.mrc_nm if object.approval_log.present?
  end

  def card_no
    card_no = object.card_no
    card_no[4..11] = '********'
    card_no
  end

  def status_txt
    object.status_txt.sval1 if object.status_txt.present?
  end

  def approval_no
    object.approval_log.apr_no if object.approval_log.present?
  end

  def cancel_yn
    object.approval_log.apr_can_yn if object.approval_log.present?
  end

  def canceled_at
    if object.approval_log.present?
      ret = "#{object.approval_log.apr_can_dtm.insert(4,'-').insert(7,'-').insert(10,' ').insert(13, ':').insert(16, ':')}"
    end

    ret
  end

  def approval_at
    if object.approval_log.present?
      ret = "#{object.approval_log.apr_dt.insert(4,'-').insert(7,'-')}"
      ret = "#{ret} #{object.approval_log.apr_t.insert(2,':').insert(5,':')}"
    end

    ret
  end

  # # 승인취소여부 Y:취소완료
  # t.string :apr_can_yn, limit: 1, comment: '승인취소여부 Y:취소완료'
  # # 승인상세일시 삼성카드 승인처리일시 yyyymmddhh24missSSS
  # t.string :apr_ts, limit: 17, comment: '승인상세일시 삼성카드 승인처리일시 yyyymmddhh24missSSS'
  # # 승인취소일시 삼성카드 취소처리일시 yyyymmddhh24miss
  # t.string :apr_can_dtm, limit: 14, comment: '승인취소일시 삼성카드 취소처리일시 yyyymmddhh24miss'

end

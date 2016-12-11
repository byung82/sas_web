class Api::V1::Usage::LimitDetSerializer < ActiveModel::Serializer
  attributes :card_no, :amt, :balance, :status_txt, :store_name, :apr_no

  def card_no
    card_no = self.object.card_no
    card_no[4..11] = '********'
    card_no
  end

  def status_txt
    self.object.status_txt.sval1 if self.object.status_txt.present?
  end

  def store_name
    object.approval_log.mrc_nm if object.approval_log.present?
  end

  def apr_no
    object.approval_log.apr_no if object.approval_log.present?
  end

end

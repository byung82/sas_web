class Api::V1::Usage::LimitDetSerializer < ActiveModel::Serializer
  attributes :card_no, :amt, :balance, :status_txt

  def card_no
    card_no = self.object.card_no
    card_no[4..11] = '********'
    card_no
  end

  def status_txt
    self.object.status_txt.sval1 if self.object.status_txt.present?
  end
end

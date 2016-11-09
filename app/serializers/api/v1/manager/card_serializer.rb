class Api::V1::Manager::CardSerializer < ActiveModel::Serializer
  attributes :id, :card_no, :limit_amt, :phone_no, :lost_yn, :created_at, :updated_at

  def card_no
    object.card_no.insert(4,'-').insert(9,'-').insert(14,'-')
  end
end

class Api::V1::Manager::ChargeSerializer < ActiveModel::Serializer
  attributes :id, :card_no, :save_amt, :updated_at, :phone_no

  def card_no
    item = object.card_no

    # item[4..8] = '********'

    item.insert(4,'-').insert(9,'-').insert(14,'-')
  end

  def phone_no
    object.store_card.phone_no
  end

  def updated_at
    object.updated_at.strftime('%Y-%m-%d %H:%M:%S')
  end
end

class Api::V1::Manager::ChargesSerializer < ActiveModel::Serializer
  attributes :total_count, :total_page, :page

  has_many :data, serializer: Api::V1::Manager::ChargeSerializer
end

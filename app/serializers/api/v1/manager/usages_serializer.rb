class Api::V1::Manager::UsagesSerializer < ActiveModel::Serializer
  attributes :total_count, :total_page, :page

  has_many :data, serializer: Api::V1::Manager::UsageSerializer
end

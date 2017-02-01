class Api::V1::Www::Usages::Index::UsagesSerializer < ActiveModel::Serializer
  attributes :total_count, :page

  has_many :items, serializer: Api::V1::Www::Usages::Index::UsageSerializer
end

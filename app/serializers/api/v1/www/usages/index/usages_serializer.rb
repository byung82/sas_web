class Api::V1::Www::Usages::Index::UsagesSerializer < ActiveModel::Serializer
  attributes :total_count, :page

  has_many :data, serializer: Api::V1::Www::Usages::Index::UsageSerializer
end

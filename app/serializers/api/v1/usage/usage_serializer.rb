class Api::V1::Usage::UsageSerializer < ActiveModel::Serializer
  attributes :success, :total_count

  has_many :items, serializer: Api::V1::Usage::LimitDetSerializer
end

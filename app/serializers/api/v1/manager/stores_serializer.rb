class Api::V1::Manager::StoresSerializer < ActiveModel::Serializer
  attributes :total_count, :total_page, :page

  has_many :data, serializer: Api::V1::Manager::StoreSerializer
end

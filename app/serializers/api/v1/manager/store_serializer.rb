class Api::V1::Manager::StoreSerializer < ActiveModel::Serializer
  attributes :id, :ceo_name, :store_name, :business_no
end

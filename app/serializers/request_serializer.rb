class RequestSerializer
  include JSONAPI::Serializer
  attributes :request_type, :request_status, :title, :description, :address, :longitude, :latitude,:created_at, :updated_at, :owner_id
end
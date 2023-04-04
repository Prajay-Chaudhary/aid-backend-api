class RequestSerializer
  include JSONAPI::Serializer
  belongs_to :user
  attributes :request_type, :request_status, :title, :description, :address, :longitude, :latitude,:created_at, :updated_at
end
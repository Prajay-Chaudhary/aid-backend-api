class RequestSerializer
  include JSONAPI::Serializer
    attributes :id, :user_id , :text , :request_id, :created_at, :updated_at, :user, :request
    belongs_to :request
    belongs_to :user
    
end

class UserSerializer
  include JSONAPI::Serializer
  has_many :requests
  attributes :id, :email, :username, :first_name, :last_name
end

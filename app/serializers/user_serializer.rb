class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email

  attribute :api_key do |object|
    object.api_keys.first[:token]
  end
end

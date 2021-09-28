RSpec.describe 'users API' do
  it 'returns the email and an api_key of a successfully registered user', :vcr do
     body = {
      email: "Whatever@example.com",
      password: "password",
      password_confirmation: "password"
    }

    post '/api/v1/users', params: body, as: :json

    expect(response).to be_successful
  end
end

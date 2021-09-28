RSpec.describe 'users API' do
  it 'returns the email and an api_key of a successfully registered user', :vcr do
    user_details = {
      email: "whatever@example.com",
      password: "password",
      password_confirmation: "password"
    }

    response = post('/api/v1/users') do |req|
      req.body = user_details.to_json
    end

    # response = Faraday.post('/api/v1/users') do |req|
    #   req.body = user_details.to_json
    # end

    expect(response).to be_successful
  end
end

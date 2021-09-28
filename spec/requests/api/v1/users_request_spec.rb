RSpec.describe 'users API' do
  it 'returns the email and an api_key of a successfully registered user', :vcr do
     body = {
      email: "Whatever@example.com",
      password: "password",
      password_confirmation: "password"
    }

    post '/api/v1/users', params: body, as: :json

    expect(response).to be_successful

    user = JSON.parse(response.body, symbolize_names: true)

    expect(user).to have_key(:data)
    expect(user[:data]).to be_a(Hash)
    expect(user[:data].keys.count).to eq(3)
    expect(user[:data]).to have_key(:id)
    expect(user[:data][:id]).to be_a(String)
    expect(user[:data]).to have_key(:type)
    expect(user[:data][:type]).to eq("user")
    expect(user[:data]).to have_key(:attributes)
    expect(user[:data][:attributes]).to be_a(Hash)
    expect(user[:data][:attributes].keys.count).to eq(2)
    expect(user[:data][:attributes]).to have_key(:email)
    expect(user[:data][:attributes][:email]).to eq(body[:email].downcase)
    expect(user[:data][:attributes]).to have_key(:api_key)
    expect(user[:data][:attributes][:email]).to be_a(String)
  end
end

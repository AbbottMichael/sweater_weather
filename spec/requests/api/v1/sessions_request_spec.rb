require 'rails_helper'

RSpec.describe 'sessions API' do
  it 'returns the email and an api_key of a user after a succesfull login', :vcr do
    User.create!(
      email: "whatever@example.com",
      password: "password",
      password_confirmation: "password"
    )
    User.last.api_keys.create!(token: SecureRandom.hex)

    body = {
      email: "Whatever@example.com",
      password: "password"
    }

    post '/api/v1/sessions', params: body, as: :json

    expect(response).to be_successful
    expect(response.status).to eq(200)

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

  it 'returns an error if email is missing', :vcr do
    body = {
      password: "password"
    }

    post '/api/v1/sessions', params: body, as: :json

    expect(response.status).to eq(400)

    message = JSON.parse(response.body, symbolize_names: true)

    expect(message).to have_key(:error)
    expect(message[:error]).to eq("Must provide an email and a password")
  end

  it 'returns an error if password is missing', :vcr do
    body = {
      email: "whatever@example.com"
    }

    post '/api/v1/sessions', params: body, as: :json

    expect(response.status).to eq(400)

    message = JSON.parse(response.body, symbolize_names: true)

    expect(message).to have_key(:error)
    expect(message[:error]).to eq("Must provide an email and a password")
  end

  it 'returns an error if the email does not match User', :vcr do
    body = {
      email: "whatever5@example.com",
      password: "password"
    }

    post '/api/v1/sessions', params: body, as: :json

    expect(response.status).to eq(404)

    message = JSON.parse(response.body, symbolize_names: true)

    expect(message).to have_key(:error)
    expect(message[:error]).to eq("The information does not match any records")
  end

  it 'returns an error if the password is incorrect', :vcr do
    User.create!(
      email: "whatever@example.com",
      password: "password",
      password_confirmation: "password"
    )
    User.last.api_keys.create!(token: SecureRandom.hex)

    body = {
      email: "whatever@example.com",
      password: "bad guess"
    }

    post '/api/v1/sessions', params: body, as: :json

    expect(response.status).to eq(404)

    message = JSON.parse(response.body, symbolize_names: true)

    expect(message).to have_key(:error)
    expect(message[:error]).to eq("The information does not match any records")
  end

  it 'returns an error if the params are passed through the uri', :vcr do
    User.create!(
      email: "whatever@example.com",
      password: "password",
      password_confirmation: "password"
    )
    User.last.api_keys.create!(token: SecureRandom.hex)

    post '/api/v1/sessions?email=whatever@example.com&password=password', params: body, as: :json

    expect(response.status).to eq(400)

    message = JSON.parse(response.body, symbolize_names: true)

    expect(message).to have_key(:error)
    expect(message[:error]).to eq("Must provide login details in the body")
  end

end

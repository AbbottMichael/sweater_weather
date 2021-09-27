require 'rails_helper'

RSpec.describe 'book-search API' do
  it 'returns current weather, quantity of books, and info about each book pertaining to a provided location city' do
    get '/api/v1/book-search?location=denver,co&quantity=5'

    expect(response).to be_successful
  end
end

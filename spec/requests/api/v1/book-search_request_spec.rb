require 'rails_helper'

RSpec.describe 'book-search API' do
  it 'returns current weather, quantity of books, and info about each book pertaining to a provided location city', :vcr do
    location = 'denver,co'
    quantity = 5
    get "/api/v1/book-search?location=#{location}&quantity=#{quantity}"

    expect(response).to be_successful

    results = JSON.parse(response.body, symbolize_names: true)

    expect(results).to have_key(:data)
    expect(results[:data]).to be_a(Hash)
    expect(results[:data].keys.count).to eq(3)
    expect(results[:data]).to have_key(:id)
    expect(results[:data][:id]).to eq("null")
    expect(results[:data]).to have_key(:type)
    expect(results[:data][:type]).to eq("books")
    expect(results[:data]).to have_key(:attributes)
    expect(results[:data][:attributes]).to be_a(Hash)

    attributes = results[:data][:attributes]
    expect(attributes.keys.count).to eq(4)
    expect(attributes).to have_key(:destination)
    expect(attributes[:destination]).to eq(location)
    expect(attributes).to have_key(:forecast)
    expect(attributes[:forecast]).to be_a(Hash)
    expect(attributes[:forecast].keys.count).to eq(2)
    expect(attributes[:forecast]).to have_key(:summary)
    expect(attributes[:forecast][:summary]).to be_a(String)
    expect(attributes[:forecast]).to have_key(:temperature)
    expect(attributes[:forecast][:temperature]).to be_a(String)
    expect(attributes).to have_key(:total_books_found)
    expect(attributes[:total_books_found]).to be_an(Integer)
    expect(attributes).to have_key(:books)
    expect(attributes[:books]).to be_an(Array)
    expect(attributes[:books].count).to eq(quantity)

    first_book = attributes[:books].first
    expect(first_book).to be_a(Hash)
    expect(first_book.keys.count).to eq(3)
    expect(first_book).to have_key(:isbn)
    expect(first_book[:isbn]).to be_an(Array)
    expect(first_book).to have_key(:title)
    expect(first_book[:title]).to be_a(String)
    expect(first_book).to have_key(:publisher)
    expect(first_book[:publisher]).to be_an(Array)



#     {
#   "data": {
#     "id": "null",
#     "type": "books",
#     "attributes": {
#       "destination": "denver,co",
#       "forecast": {
#         "summary": "Cloudy with a chance of meatballs",
#         "temperature": "83 F"
#       },
#       "total_books_found": 172,
#       "books": [
#         {
#           "isbn": [
#             "0762507845",
#             "9780762507849"
#           ],
#           "title": "Denver, Co",
#           "publisher": [
#             "Universal Map Enterprises"
#           ]
#         },
#         {
#           "isbn": [
#             "9780883183663",
#             "0883183668"
#           ],
#           "title": "Photovoltaic safety, Denver, CO, 1988",
#           "publisher": [
#             "American Institute of Physics"
#           ]
#         },
#       ]
#     }
#   }
# }
  end
end

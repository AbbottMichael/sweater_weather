require 'rails_helper'

RSpec.describe BookService do
  context 'class methods' do
    context '::get_books_by_city' do
      it 'returns info on books of a given city', :vcr do
        quantity = 5
        books = BookService.get_books_by_city('denver,co', quantity)
        expect(books).to be_a(Hash)
        expect(books).to have_key(:numFound)
        expect(books[:numFound]).to be_an(Integer)
        expect(books).to have_key(:docs)
        expect(books[:docs]).to be_an(Array)
        expect(books[:docs].count).to eq(quantity)

        first_book = books[:docs].first
        expect(first_book).to be_a(Hash)
        expect(first_book).to have_key(:isbn)
        expect(first_book[:isbn]).to be_an(Array)
        expect(first_book[:isbn].first).to be_a(String)
        expect(first_book).to have_key(:title)
        expect(first_book[:title]).to be_a(String)
        expect(first_book).to have_key(:publisher)
        expect(first_book[:publisher]).to be_an(Array)
        expect(first_book[:publisher].first).to be_a(String)
      end
    end
  end
end

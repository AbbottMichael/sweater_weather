require 'rails_helper'

RSpec.describe BookService do
  context 'class methods' do
    context '::get_books_by_city' do
      it 'returns info on books of a given city', :vcr do
        books = BookService.get_books_by_city('denver,co', 5)
        expect(books).to be_a(Hash)
      end
    end
  end
end

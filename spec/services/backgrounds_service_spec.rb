require 'rails_helper'

RSpec.describe BackgroundsService do
  context 'class methods' do
    context '::get_image_by_location' do
      it 'returns image results based on a search query', :vcr do
        search = BackgroundsService.get_image_by_location('denver,co')
        
        expect(search).to be_a(Hash)
      end
    end
  end
end

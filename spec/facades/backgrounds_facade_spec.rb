require 'rails_helper'

RSpec.describe BackgroundsFacade do
  context "class methods" do
    context "::image_by_location" do
      it "returns a Background object", :vcr do
        results = BackgroundsFacade.image_by_location('denver,co')

        expect(results).to be_a(Background)
      end
    end
  end
end

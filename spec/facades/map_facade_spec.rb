require 'rails_helper'

RSpec.describe MapFacade do
  context "class methods" do
    context "::lat_lng" do
      it "returns a Map object", :vcr do
        results = MapFacade.lat_lng('denver,co')

        expect(results).to be_a(Map)
      end
    end
  end
end

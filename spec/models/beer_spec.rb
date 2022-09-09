require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe "with a brewery" do
    let(:test_brewery) { Brewery.new name: "test", year: 2000 }

    it "is saved with name, style and brewery" do
      beer = Beer.create name: "Lapin Kulta", style: "IPA", brewery: test_brewery
  
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end

    it "is not saved without name" do
      beer = Beer.create style: "IPA", brewery: test_brewery
  
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end

    it "is not saved without style" do
      beer = Beer.create name: "Lapin Kulta", brewery: test_brewery
  
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end

  end
end

require 'rails_helper'

describe "Beers page" do

  describe "when adding beer" do
    before :each do
      FactoryBot.create(:brewery, name: "Koff", year: 1912)
      FactoryBot.create(:user)
      sign_in(username: "Pekka", password: "Foobar1")
    end

    it "with valid name" do
      visit new_beer_path
      fill_in('beer_name', with: 'Lapin Kulta')
      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(1)
    end

    it "without name" do
      visit new_beer_path
      fill_in('beer_name', with: '')
      click_button('Create Beer')
      expect(current_path).to eq(beers_path)
      expect(page).to have_content 'Name can\'t be blank'
      expect(Beer.count).to eq(0)
    end

  end
end
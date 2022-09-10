require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    FactoryBot.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  describe "ratings are listed properly" do
    let!(:user1) { FactoryBot.create :user, username: 'migi' }
    let!(:user2) { FactoryBot.create :user, username: 'magi' }

    it "without other users ratings" do
      FactoryBot.create :rating, user: user1, score: 11
      FactoryBot.create :rating, user: user1, score: 12
      FactoryBot.create :rating, user: user2, score: 13
      visit user_path(user1)
      expect(page).to have_content "anonymous 11"
      expect(page).to have_content "anonymous 12"
      expect(page).not_to have_content "anonymous 13"
    end
  end

  describe "Ratings can be deleted" do
    let!(:user1) { FactoryBot.create :user, username: 'migi' }
    let!(:review1) { FactoryBot.create :rating, user: user1, score: 11 }
    let!(:review2) { FactoryBot.create :rating, user: user1, score: 12 }
    let!(:review3) { FactoryBot.create :rating, user: user1, score: 13 }

    it "from user's page" do
      sign_in(username: "migi", password: "Foobar1")
      visit user_path(user1)
      expect(Rating.count).to eq(3)
      within(find_by_id("rating_2")) do
        click_link('Delete')
      end
      expect(Rating.count).to eq(2)
      expect(page).to have_content "anonymous 11"
      expect(page).to have_content "anonymous 13"
    end
  end

  describe "Favorite" do
    let!(:user1) { FactoryBot.create :user, username: 'migi' }
    let!(:brewery1) { FactoryBot.create :brewery, name: 'Koff'}
    let!(:brewery2) { FactoryBot.create :brewery, name: 'Olvi'}
    let!(:brewery3) { FactoryBot.create :brewery, name: 'Sandels'}
    let!(:beer1) { FactoryBot.create :beer, name: "Iso 1", style: 'APA', brewery: brewery1}
    let!(:beer2) { FactoryBot.create :beer, name: "Iso 2", style: 'IPA', brewery: brewery2}
    let!(:beer3) { FactoryBot.create :beer, name: "Iso 3", style: 'OPA', brewery: brewery3}
    let!(:review1) { FactoryBot.create :rating, user: user1, score: 11, beer: beer1 }
    let!(:review2) { FactoryBot.create :rating, user: user1, score: 22, beer: beer2 }
    let!(:review3) { FactoryBot.create :rating, user: user1, score: 13, beer: beer3 }

    it "style is found" do
      sign_in(username: "migi", password: "Foobar1")
      visit user_path(user1)
      expect(page).to have_content "Favorite style: IPA"
    end

    it "brewery is found" do
      sign_in(username: "migi", password: "Foobar1")
      visit user_path(user1)
      expect(page).to have_content "Favorite brewery: Olvi"
    end
  end
end
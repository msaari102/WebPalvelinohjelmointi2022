require 'rails_helper'

def create_beer_with_rating(object, score)
  beer = FactoryBot.create(:beer)
  FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
  beer
end

def create_beers_with_many_ratings(object, *scores)
  scores.each do |score|
    create_beer_with_rating(object, score)
  end
end

def create_many_beers_with_ratings(user)
  brew1 = FactoryBot.create(:brewery, name: "yksi")
  brew2 = FactoryBot.create(:brewery, name: "kaksi")
  brew3 = FactoryBot.create(:brewery, name: "kolme")

  beer1 = FactoryBot.create(:beer, style: "IPA", brewery: brew1)
  beer2 = FactoryBot.create(:beer, style: "Lager", brewery: brew1)
  beer3 = FactoryBot.create(:beer, style: "APA", brewery: brew1)
  beer4 = FactoryBot.create(:beer, style: "APA", brewery: brew1)
  beer5 = FactoryBot.create(:beer, style: "IPA", brewery: brew2)
  beer6 = FactoryBot.create(:beer, style: "APA", brewery: brew2)
  beer7 = FactoryBot.create(:beer, style: "APA", brewery: brew2)
  beer8 = FactoryBot.create(:beer, style: "Lager", brewery: brew3)
  beer9 = FactoryBot.create(:beer, style: "Lager", brewery: brew3)

  rat1 = FactoryBot.create(:rating, beer: beer1, score: 2, user: user )
  rat2 = FactoryBot.create(:rating, beer: beer2, score: 1, user: user )
  rat3 = FactoryBot.create(:rating, beer: beer3, score: 22, user: user )
  rat4 = FactoryBot.create(:rating, beer: beer4, score: 21, user: user )
  rat5 = FactoryBot.create(:rating, beer: beer5, score: 9, user: user )
  rat6 = FactoryBot.create(:rating, beer: beer6, score: 23, user: user )
  rat7 = FactoryBot.create(:rating, beer: beer7, score: 22, user: user )
  rat8 = FactoryBot.create(:rating, beer: beer8, score: 30, user: user )
  rat9 = FactoryBot.create(:rating, beer: beer9, score: 30, user: user )
end

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username: "Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a short password" do
    user = User.create username: "Pekka", password: "Se1", password_confirmation: "Se1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a password with only small letters" do
    user = User.create username: "Pekka", password: "abcd", password_confirmation: "abcd"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user) { FactoryBot.create(:user) }
  
    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end
  
    it "and with two ratings, has the correct average rating" do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)
  
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user){ FactoryBot.create(:user) }
  
    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end
  
    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

  it "is the only rated if only one rating" do
    beer = FactoryBot.create(:beer)
    rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)
  
    expect(user.favorite_beer).to eq(beer)
  end

  it "is the one with highest rating if several rated" do
    create_beer_with_rating({ user: user }, 10 )
    create_beer_with_rating({ user: user }, 7 )
    best = create_beer_with_rating({ user: user }, 25 )
  
    expect(user.favorite_beer).to eq(best)
  end
end  

  describe "favorite style" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_style)
    end

  it "is the one with highest average rating if several rated" do
    create_many_beers_with_ratings(user)
    expect(user.favorite_style).to eq("APA")
  end
end  

  describe "favorite brewery" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_brewery)
    end

    it "is the one with highest average rating if several rated" do
      create_many_beers_with_ratings(user)
      expect(user.favorite_brewery).to eq("kolme")
    end  

  end

end
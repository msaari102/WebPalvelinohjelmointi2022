class User < ApplicationRecord
  include RatingAverage

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }
  validates :password, length: { minimum: 4 },
                       format: { with: /([A-Z]+.*\d)|(\d.*[A-Z])/, message: "password must include capital letter and digit" }

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
  has_secure_password

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_by(my_ratings, criteria)
    by_criteria = my_ratings
                  .group_by { |rating| rating.beer.send(criteria) }
                  .map { |key, val| [key, val.sum(&:score) / val.size] }

    by_criteria.max_by(&:last).first
  end

  def favorite_style
    return nil if ratings.empty?

    favorite_by(ratings, :style)
  end

  def favorite_brewery
    return nil if ratings.empty?

    favorite_by(ratings, :brewery)
  end

  def self.top(num)
    User.all.sort_by{ |b| b.ratings.count }.reverse.first(num)
  end
end

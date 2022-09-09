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

  def favorite_style
    return nil if ratings.empty?

    tulos = ratings.group_by { |i| i.beer.style }.transform_values { |i| i.inject(0) { |sum, n| sum + n.score } / i.count.to_f }
    tulos.min { |a, b| b[1] <=> a[1] }[0]
  end

  def favorite_brewery
    return nil if ratings.empty?

    tulos = ratings.group_by { |i| i.beer.brewery.name }.transform_values { |i| i.inject(0) { |sum, n| sum + n.score } / i.count.to_f }
    tulos.min { |a, b| b[1] <=> a[1] }[0]
  end
end

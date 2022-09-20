class Style < ApplicationRecord
  has_many :beers
  has_many :ratings, through: :beers

  def self.top(num)
    Style.all.sort_by(&:average_rating).reverse.first(num)
  end

  include RatingAverage
end

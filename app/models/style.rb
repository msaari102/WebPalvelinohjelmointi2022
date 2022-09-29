class Style < ApplicationRecord
  extend Top
  has_many :beers
  has_many :ratings, through: :beers

  validates :name, presence: true

  # def self.top(amount)
  #  sorted_by_rating_in_desc_order = Style.all.sort_by{ |b| -(b.average_rating || 0) }
  #  sorted_by_rating_in_desc_order[0, amount]
  # end

  include RatingAverage
end

class Beer < ApplicationRecord
  include RatingAverage

  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user

  validates :name, presence: true
  validates :style, presence: true

  def to_s
    "#{name} #{brewery.name}"
  end

  def average
    if ratings.count == 0
      return 0
    end

    ratings.map(&:score).sum / ratings.count.to_f
  end

  def self.top(num)
    Beer.all.sort_by(&:average_rating).reverse.first(num)
  end
end

class Brewery < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  #validates :year, numericality: { greater_than_or_equal_to: 1040,
  #  less_than_or_equal_to: 2022,
  #  only_integer: true }

  validates :name, presence: true

  validate :year_limits

def year_limits
  if year.present? && year < 1040 || year > Date.today.year
    errors.add(:year, "Year must be between this year and 1040")
  end
end

  def year
    read_attribute(:year)
  end

  def year=(value)
    write_attribute(:year, value)
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2022
    puts "changed year to #{year}"
  end
end

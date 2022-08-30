class Brewery < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def year
    read_attribute(:year)
  end

  def year=(value)
    write_attribute(:year, value)
  end

  def print_report
    puts self.name
    puts "established at year #{self.year}"
    puts "number of beers #{self.beers.count}"
  end

  def restart
    self.year = 2022
    puts "changed year to #{year}"
  end
  
end

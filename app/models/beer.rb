class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings

  def average_rating
    self.ratings.map {|i| i.score}.sum.to_f / self.ratings.length
  end

end

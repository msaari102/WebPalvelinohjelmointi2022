module RatingAverage
  extend ActiveSupport::Concern
    def average_rating
      self.ratings.map {|i| i.score}.sum.to_f / self.ratings.length
    end
 end
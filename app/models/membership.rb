class Membership < ApplicationRecord
  belongs_to :beer_club
  belongs_to :user   # rating kuuluu myös käyttäjään
end

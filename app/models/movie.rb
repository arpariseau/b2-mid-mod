class Movie < ApplicationRecord
  validates_presence_of :title, :year, :genre
  belongs_to :studio
end

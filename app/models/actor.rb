class Actor < ApplicationRecord
  validates_presence_of :name, :age
  has_many :movie_actors
  has_many :movies, through: :movie_actors
end

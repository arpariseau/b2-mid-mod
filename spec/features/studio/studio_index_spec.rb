require 'rails_helper'

RSpec.describe "Studio index page", type: :feature do
  mgm = Studio.create(name: "Metro Goldywn Meyer",
                      location: "Beverly Hills, CA")
  fox = Studio.create(name: "20th Century Fox",
                      location: "Los Angeles, CA")
  ben_hur = Movie.create(title: "Ben-Hur",
                         year: 1959,
                         genre: "epic",
                         studio_id: mgm.id)
  odyssey = Movie.create(title: "2001: A Space Odyssey",
                         year: 1968,
                         genre: "sci-fi",
                         studio_id: mgm.id)
   apes = Movie.create(title: "Planet of the Apes",
                       year: 1968,
                       genre: "sci-fi",
                       studio_id: fox.id)

   visit "/studios"

   within(".studio-#{mgm.id}") do
     expect(page).to have_content(mgm.name)
     expect(page).to have_content(ben_hur.name)
     expect(page).to have_content(odyssey.name)
   end

   within(".studio-#{fox.id}") do
     expect(page).to have_content(fox.name)
     expect(page).to have_content(apes.name)
   end
end

# Story 1
# As a visitor,
# When I visit the studio index page
# I see a list of all of the movie studios
# And underneath each studio, I see the names of all of its movies.

# Studios have a name and location
# Movies have a title, creation year, and genre
# Actors have a name and age

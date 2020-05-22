require 'rails_helper'

RSpec.describe "Studio index page", type: :feature do
  it "can list all movie studios" do
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
      expect(page).to have_content(ben_hur.title)
      expect(page).to have_content(odyssey.title)
    end

    within(".studio-#{fox.id}") do
      expect(page).to have_content(fox.name)
      expect(page).to have_content(apes.title)
    end
  end
end

require 'rails_helper'

RSpec.describe "Movie show page", type: :feature do
  before :each do
    warner = Studio.create(name: "Warner Brothers",
                           location: "Burbank, CA")

    @departed = Movie.create(title: "The Departed",
                            year: 2006,
                            genre: "crime",
                            studio_id: warner.id)

    @leo = Actor.create(name: "Leonardo DiCaprio",
                        age: 32)
    @jack = Actor.create(name: "Jack Nicholson",
                         age: 69)
    @matt = Actor.create(name: "Matt Damon",
                         age: 36)
    @mark = Actor.create(name: "Mark Wahlberg",
                         age: 35)

    MovieActor.create(movie_id: @departed.id, actor_id: @leo.id)
    MovieActor.create(movie_id: @departed.id, actor_id: @jack.id)
    MovieActor.create(movie_id: @departed.id, actor_id: @matt.id)
    MovieActor.create(movie_id: @departed.id, actor_id: @mark.id)
  end

  it "can show information about a movie" do
    visit "/movies/#{@departed.id}"

    expect(page).to have_content(@departed.title)
    expect(page).to have_content(@departed.year)
    expect(page).to have_content(@departed.genre)

    expect(page).to have_content(@leo.name)
    expect(page).to have_content(@jack.name)
    expect(page).to have_content(@matt.name)
    expect(page).to have_content(@mark.name)

    expect(@leo.name).to appear_before(@mark.name)
    expect(@mark.name).to appear_before(@matt.name)
    expect(@matt.name).to appear_before(@jack.name)

    avg_age = (@leo.age + @jack.age + @matt.age + @mark.age).to_f / 4
    expect(page).to have_content(avg_age)
  end

  it "can add an actor through a form" do
    martin = Actor.create(name: "Martin Sheen", age: 66)

    visit "/movies/#{@departed.id}"
    fill_in :actor_name, with: martin.name
    click_button "Add Actor"

    expect(current_path).to eq("/movies/#{@departed.id}")
    expect(page).to have_content(martin.name)

    expect(martin.name).to appear_before(@jack.name)
    expect(@matt.name).to appear_before(martin.name)
  end
end

# Story 3
# As a visitor,
# When I visit a movie show page,
# I see a form for an actors name
# and when I fill in the form with an existing actor's name
# I am redirected back to that movie's show page
# And I see the actor's name listed

require 'rails_helper'

RSpec.describe "Actor show page", type: :feature do
  it "can list an actor and the actors they've worked with" do
    warner = Studio.create(name: "Warner Brothers",
                           location: "Burbank, CA")
    united = Studio.create(name: "United Artists",
                           location: "Hollywood, CA")

    apocalypse = Movie.create(title: "Apocalypse Now",
                           year: 1979,
                           genre: "war",
                           studio_id: united.id)
    departed = Movie.create(title: "The Departed",
                            year: 2006,
                            genre: "crime",
                            studio_id: warner.id)

    martin = Actor.create(name: "Martin Sheen", age: 66)
    marlon = Actor.create(name: "Marlon Brando", age: 82)
    laurence = Actor.create(name: "Laurence Fishburne", age: 45)
    leo = Actor.create(name: "Leonardo DiCaprio", age: 32)
    jack = Actor.create(name: "Jack Nicholson", age: 69)

    MovieActor.create(movie_id: apocalypse.id, actor_id: martin.id)
    MovieActor.create(movie_id: apocalypse.id, actor_id: marlon.id)
    MovieActor.create(movie_id: apocalypse.id, actor_id: laurence.id)
    MovieActor.create(movie_id: departed.id, actor_id: martin.id)
    MovieActor.create(movie_id: departed.id, actor_id: leo.id)
    MovieActor.create(movie_id: departed.id, actor_id: jack.id)

    visit "/actors/#{martin.id}"
    expect(page).to have_content(martin.name)
    expect(page).to have_content(martin.age)

    expect(page).to have_content(marlon.name)
    expect(page).to have_content(laurence.name)
    expect(page).to have_content(leo.name)
    expect(page).to have_content(jack.name)
  end
end

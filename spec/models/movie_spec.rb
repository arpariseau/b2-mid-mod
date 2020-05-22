require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe "relationships" do
    it {should belong_to :studio}
    it {should have_many :movie_actors}
    it {should have_many(:actors).through(:movie_actors)}
  end

  describe "methods" do
    before :each do
      mgm = Studio.create(name: "Metro Goldywn Meyer",
                          location: "Beverly Hills, CA")

      @oz = Movie.create(title: "The Wizard of Oz",
                         year: 1939,
                         genre: "musical",
                         studio_id: mgm.id)

      @judy = Actor.create(name: "Judy Garland", age: 17)
      @bert = Actor.create(name: "Bert Lahr", age: 44)
      @jack = Actor.create(name: "Jack Haley", age: 42)
      @ray = Actor.create(name: "Ray Bolger", age: 35)

      MovieActor.create(movie_id: @oz.id, actor_id: @judy.id)
      MovieActor.create(movie_id: @oz.id, actor_id: @bert.id)
      MovieActor.create(movie_id: @oz.id, actor_id: @jack.id)
      MovieActor.create(movie_id: @oz.id, actor_id: @ray.id)
    end

    it '#actors_by_age' do
      expect(@oz.actors_by_age.first).to eq(@judy)
      expect(@oz.actors_by_age.last).to eq(@bert)
    end

    it '#avg_actors_age' do
      avg_age = (@judy.age + @ray.age + @jack.age + @bert.age).to_f / 4
      expect(@oz.avg_actors_age).to eq(avg_age)
    end
  end
end

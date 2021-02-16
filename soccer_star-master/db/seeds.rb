# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'faker'

30.times do
    
    Team.create(name: Faker::Sports::Football.team, country: Faker::Address.country)

end

30.times do
    
    Player.create(name: Faker::Sports::Football.player, gender: ["male", "female"].sample)
end 


50.times do 

     User.create(name: Faker::Name.name, email: Faker::Internet.email, password: "soccer")
 
end 


50.times do 
    Review.create(stars: Faker::Number.between(from: 1, to: 5), title: Faker::Game.title)
end 

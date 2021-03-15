# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
100.times do
    User.create(
        name: Faker::Name.name_with_middle,
        email: Faker::Internet.free_email,   
    )
end

100.times do
    Micropost.create(
        titel: Faker::Lorem.sentence(word_count: 3),
        content: Faker::Lorem.sentence(word_count: 10),
        user_id: Faker::Number.between(from: 1, to: 100),
    )
end

300.times do
    Comment.create(
        name: Faker::Name.name,
        body: Faker::Lorem.sentence(word_count: 5),
        micropost_id: Faker::Number.between(from: 1, to: 100),
    )
end
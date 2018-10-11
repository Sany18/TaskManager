# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
include Faker

for i in 0..16
  Task.create(
      id: Number.number( 5 ),
      title: Book.title,
      theme: Hacker.say_something_smart,
      priority: rand( 1..5 ),
      due_date: Date.today,
      user_id: 1,
      is_done: rand(2) == 1
  )
end

User.create(
    first_name: Name::first_name,
    last_name: Name::last_name,
    email: "w@w",
    password: "asdasd",
    password_confirmation: "asdasd",
    confirmed_at: Date.today
)
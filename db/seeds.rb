# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
include Faker

if Rails.env != "production"
  User.create(
    first_name: Name.first_name,
    last_name: Name.last_name,
    email: "test@test.com",
    password: "asdqwe123",
    password_confirmation: "asdqwe123",
    confirmed_at: Date.today
  )

  16.times do
    Task.create(
      title: Book.title,
      theme: Hacker.say_something_smart,
      priority: rand(1..5),
      due_date: Date.today,
      is_done: rand(2) == 1
    )
  end
end
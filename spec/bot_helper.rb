FactoryBot.define do
  factory :user do
    first_name {Faker::Name::first_name}
    last_name {Faker::Name::last_name}
    email {Faker::Internet.email}
    password {"password"}
    password_confirmation {"password"}
    confirmed_at {Date.today}
  end

  factory :task do
    id {Faker::Number.number(5)}
    title {Faker::Job.title}
    theme {Faker::Hacker.say_something_smart}
    priority {rand(0..5)}
    term {Date.today}
    user_id {Faker::Number.number(1)}
  end
end
FactoryBot.define do
  factory :user do
    first_name {Faker::Name::first_name}
    last_name {Faker::Name::last_name}
    email {Faker::Internet.email}
    password {"password"}
    password_confirmation {"password"}
    confirmed_at {Date.today}
  end
end

FactoryBot.define do
  factory :task do
    id {1}
    title {'task'}
    theme {'theme'}
    priority {'3'}
    term {'1234-12-12'}
    user_id {1}
    is_done {0}
  end
end
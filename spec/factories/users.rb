FactoryBot.define do
  factory :user do
    name { "test" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { "testuser" }

    trait :have_posts do
      after(:create) { |user| create_list(:post, 5, user: user) }
    end
  end
end

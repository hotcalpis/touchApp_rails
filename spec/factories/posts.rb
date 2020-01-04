FactoryBot.define do
  factory :post do
    sequence(:id) { |i| i }
    title { "TestTitle" }
    content { "TestContent" }
    association :user
  end
end

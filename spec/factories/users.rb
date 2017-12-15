FactoryBot.define do
  factory :user do
    sequence :email { |n| "user#{n}@example.com" }
    password 'p4$$w0rd'
  end
end

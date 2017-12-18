FactoryBot.define do
  factory :account do
    balance 1
    association :user
  end
end

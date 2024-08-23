FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "タイトル#{n}" }
    sequence(:users_scam_name) { |n| "詐欺名#{n}"}
    sequence(:body) { |n| "本文#{n}" }
    association :user
  end
end

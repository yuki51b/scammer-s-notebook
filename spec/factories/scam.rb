FactoryBot.define do
  factory :scam do
    sequence(:name) { |n| "詐欺名#{n}" }
    sequence(:content) { |n| "詐欺名#{n}の一言詳細" }
    sequence(:point_1) { |n| "1の対策ポイント#{n}" }
    sequence(:point_2) { |n| "2の対策ポイント#{n}" }
    sequence(:point_3) { |n| "3の対策ポイント#{n}" }
    sequence(:scam_strategy) { |n| "詐欺師の手口#{n}" }
  end
end

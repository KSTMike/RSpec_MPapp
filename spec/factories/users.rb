FactoryBot.define do
  factory :user, aliases: [:owner] do
  # factory :user do
    first_name { "Aaron" }
    last_name  { "Sumner" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    # email { "tester@example.com" }
    password { "dottle-nouveau-pavilion-tights-furze" }
  end
end

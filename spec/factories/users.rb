FactoryBot.define do
  factory :user do
    name { "Test User" }
    # 'sequence' garante que cada email seja único, adicionando um número
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "password" }
  end
end

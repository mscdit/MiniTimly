FactoryBot.define do
  factory :user do
    id { 5 }
    email { 'max@mustermann.com' }
    password { 'password' }
  end
end

FactoryBot.define do
  factory :user do
    id { 1 }
    email { 'max@mustermann.com' }
    password { 'password' }
  end
end

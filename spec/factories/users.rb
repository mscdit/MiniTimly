FactoryBot.define do
  factory :user do
    email { 'max@mustermann.com' }

    after(:build) { |u| u.password_confirmation = u.password = '123456' }
    after(:create) { |u| u.create_profile(api_key: '123456xyz') }
  end
end
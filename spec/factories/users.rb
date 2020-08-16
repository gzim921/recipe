FactoryBot.define do
  factory :user do
    first_name { 'Gzim' }
    last_name { 'Iseni' }
    user_name { 'gzim921' }
    sequence(:email) { |n| "tester#{n}@tester.com" }
    password { '123123' }
    password_confirmation { '123123' }
  end
end

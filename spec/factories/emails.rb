# frozen_string_literal: true

FactoryBot.define do
  factory :email do
    email { Faker::Internet.email }
    app { Faker::Name.name }
  end
end

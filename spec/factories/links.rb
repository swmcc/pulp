# frozen_string_literal: true

FactoryBot.define do
  factory :link do
    title { Faker::Alphanumeric.alphanumeric(number: 10) }
    page { Faker::Internet.url }
  end
end

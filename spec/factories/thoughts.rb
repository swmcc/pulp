# frozen_string_literal: true

FactoryBot.define do
  factory :thought do
    thought { Faker::Quote.famous_last_words }
    sparked_at { Faker::Date.between(from: 2.days.ago, to: Date.today) }
  end
end

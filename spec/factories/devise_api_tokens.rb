# frozen_string_literal: true

FactoryBot.define do
  factory :devise_api_token do
    resource_owner_type { 'User' }
    resource_owner_id { create(:user).id }
    access_token { Faker::Alphanumeric.alphanumeric(number: 10) }
    refresh_token { Faker::Alphanumeric.alphanumeric(number: 10) }
    expires_in { 3600 }
  end

  trait :expired do
    created_at { 2.hours.ago }
  end
end

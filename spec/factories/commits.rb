FactoryBot.define do
  factory :commit do
    repo_name { Faker::App.name }
    sha { Faker::Crypto.sha1 }
    message { Faker::Lorem.sentence }
    commit_date { Faker::Date.between(from: 2.weeks.ago, to: Date.today) }
  end
end

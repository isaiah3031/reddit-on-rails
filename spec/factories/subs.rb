FactoryBot.define do
  factory :sub do
    title { Faker::Lorem.words }
    description { Faker::Lorem.sentence(word_count: 3, supplemental: true)}
  end
end

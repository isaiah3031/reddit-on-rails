FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence(word_count: 2, supplemental: true) }
    url { Faker::Internet.url }
    content { Faker::Lorem.sentence(word_count: 10, supplemental: true)}
    author_id { 1 }
    sub_ids { 1 }
  end
end

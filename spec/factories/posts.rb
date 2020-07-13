FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence(word_count: 2 supplemental: true) }
    url { "MyString" }
    content { Faker::Lorem.sentence(word_count: 10, supplemental: true)}
    sub_id { 1 }
    author_id { 1 }
  end
end

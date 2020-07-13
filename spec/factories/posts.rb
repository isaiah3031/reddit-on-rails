FactoryBot.define do
  factory :post do
    title { "MyString" }
    url { "MyString" }
    content { "MyText" }
    sub_id { 1 }
    author_id { 1 }
  end
end

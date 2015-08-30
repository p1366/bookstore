FactoryGirl.define do
  factory :book do
    association :publisher

    title { Faker::Book.title }
  end
end

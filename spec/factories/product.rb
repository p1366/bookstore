FactoryGirl.define do
  factory :product do
    association :shop
    association :book

    copies_in_stock { Faker::Number.between(1, 10) }
    copies_sold     0
  end
end

FactoryBot.define do
  factory :subcategory do
    name { "Rachunki" }
    category { association :category, name: "Category #{rand(1..1000)}" }
  end
end

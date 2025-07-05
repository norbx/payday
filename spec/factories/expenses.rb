FactoryBot.define do
  factory :expense do
    amount { rand(1..1000) }
    description { "Expense #{rand(1000)}" }
    date { Date.today }
    association :category
    association :expenses_import
  end
end

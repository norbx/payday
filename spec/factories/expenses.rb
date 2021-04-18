FactoryBot.define do
  factory :expense do
    transaction_date { Time.current }
    amount { -100 }
    description { 'Carrefour' }
    localization { 'Warsaw' }
    referential_number { '12351RASD123123' }
  end
end
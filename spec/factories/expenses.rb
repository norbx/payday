FactoryBot.define do
  factory :expense do
    transaction_date { Time.current }
    amount { Faker::Number.decimal(l_digits: 2) }
    description { Faker::Appliance.equipment }
    localization { Faker::Games::ElderScrolls.city }
    referential_number { Faker::Finance.vat_number(country: 'DE') }

    trait :with_report do
      report { create(:report) }
    end
  end
end
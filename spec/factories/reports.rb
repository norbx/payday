# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    from { 1.day.ago }
    to { 3.days.ago }

    trait :with_expenses do
      expenses { create_list(:expense, 2, transaction_date: 2.days.ago) }
    end
  end
end

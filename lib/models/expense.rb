class Expense < ActiveRecord::Base
  belongs_to :category, optional: true
  belongs_to :monthly_report, optional: true

  validates_uniqueness_of :amount, scope: %i[transaction_date localization description]
end

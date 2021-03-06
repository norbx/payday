class Expense < ActiveRecord::Base
  belongs_to :category, optional: true
  belongs_to :monthly_report, optional: true
end

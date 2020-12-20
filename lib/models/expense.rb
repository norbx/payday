class Expense < ActiveRecord::Base
  belongs_to :category
  belongs_to :monthly_report
end

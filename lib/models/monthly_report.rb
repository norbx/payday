class MonthlyReport < ActiveRecord::Base
  has_many :expenses
end

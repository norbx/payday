class Expense < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :expenses_import
end

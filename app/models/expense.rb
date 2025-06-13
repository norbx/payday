class Expense < ApplicationRecord
  belongs_to :category, optional: true
end

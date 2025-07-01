class Expense < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :expenses_import

  validates :date, presence: true
  validates :amount, presence: true
  validates_uniqueness_of :description, scope: [ :date, :amount ]
end

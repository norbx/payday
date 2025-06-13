class ExpensesImport < ApplicationRecord
  has_many :expenses, dependent: :destroy

  validates :file_name, presence: true
  validates :imported_at, presence: true
  validates :state, presence: true, inclusion: { in: %w[pending completed failed] }
end

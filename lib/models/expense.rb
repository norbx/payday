class Expense < ActiveRecord::Base
  belongs_to :category, optional: true
  belongs_to :report, optional: true

  scope :unreported, -> { where(report_id: nil) }
  scope :for_date, ->(date) { where(transaction_date: date) }

  def self.first_unreported
    unreported.order(transaction_date: :asc).pluck(:transaction_date).first
  end
end

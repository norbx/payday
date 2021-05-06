class Report < ActiveRecord::Base
  has_many :expenses

  def self.last_report_date
    order(to: :asc).pluck(:to).last
  end
end

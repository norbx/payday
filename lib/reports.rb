class Reports
  def initialize(payday:)
    @payday = payday
  end

  def call
    Report.create!(from: date_from, to: payday, expenses: expenses)
  end

  private

  def date_from
    return last_report_date.beginning_of_day + 1.day if last_report_date.present?

    Expense.first_unreported
  end

  def last_report_date
    @last_report_date ||= Report.last_report_date
  end

  def payday
    (@payday - 1.day).end_of_day
  end

  def expenses
    Expense.unreported.for_date(date_from..payday)
  end
end

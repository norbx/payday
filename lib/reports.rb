class Reports
  def initialize(csv, date_from:, date_to:, categories: Categories, balance: Balance)
    @csv = csv
    @date_from = date_from.to_date
    @date_to = date_to.to_date
    @categories = categories.new(csv)
    @balance = balance.new(csv)
    @report = nil
  end

  def create_report
    calculate_balance
    categorize
    save_report
  end

  private

  attr_reader :csv, :categories, :balance, :date_from, :date_to

  def calculate_balance
    @balance = balance.calculate
  end

  def categorize
    @categorized_csv = categories.categorize
  end

  def save_report
    @report = MonthlyReport.create!(
      from: date_from,
      to: date_to,
      income: balance[:income],
      expense: balance[:expense]
    )
  end
end

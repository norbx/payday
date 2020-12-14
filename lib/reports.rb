class Reports
  def initialize(csv, categories = Categories, balance = Balance, date_from:, date_to:)
    @csv = csv
    @date_from = date_from.to_date
    @date_to = date_to.to_date
    @categories = categories.new(csv, date_from, date_to)
    @categories_report = nil
    @balance = balance.new(csv, date_from, date_to)
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
    @categories_report = categories.categorize
  end

  def save_report
    report = MonthlyReport.create!(
      from: date_from,
      to: date_to,
      income: balance[:income],
      expense: balance[:expense]
    )
    @categories_report.each_pair do |category, amount|
      Category.create!(name: category, amount: amount, monthly_report: report)
    end
  end
end

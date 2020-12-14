class Reports
  def initialize(csv, month, year, categories = Categories)
    @csv = csv
    @month = month
    @year = year
    @income = 0
    @expense = 0
    @categories = categories.new(csv, month)
    @categories_report = nil
  end

  def create_report
    calculate_balance
    categorize
    save_report
  end

  private

  attr_reader :csv, :month, :year, :categories, :income, :expense

  def calculate_balance
    csv.each do |row|
      next unless row['Parsed date'].month == month

      if row['Kwota'].to_f.positive?
        @income += row['Kwota'].to_f
      else
        @expense += row['Kwota'].to_f
      end
    end
  end

  def categorize
    @categories_report = categories.categorize
  end

  def save_report
    report = MonthlyReport.create!(
      month: month,
      year: year,
      income: income,
      expense: expense
    )
    @categories_report.each_pair do |category, amount|
      Category.create!(name: category, amount: amount, monthly_report: report)
    end
  end
end

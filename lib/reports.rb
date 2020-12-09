class Reports
  def initialize(csv, month, categories = Categories)
    @csv = csv
    @month = month
    @expenses = 0
    @income = 0
    @categories = categories.new(csv, month)
  end

  def monthly_report
    csv.each do |row|
      next unless row['Parsed date'].month == month

      if row['Kwota'].to_f.positive?
        @income += row['Kwota'].to_f
      else
        @expenses += row['Kwota'].to_f
      end
    end
    [@income, @expenses]
  end

  def categories_report
    categories.categorize
  end

  private

  attr_reader :csv, :month, :categories
end

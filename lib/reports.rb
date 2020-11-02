class Reports
  def initialize(csv, month)
    @csv = csv
    @month = month
    @expenses = 0
    @income = 0
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

  private

  attr_reader :csv, :month
end

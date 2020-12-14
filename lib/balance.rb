class Balance
  def initialize(csv, date_from, date_to)
    @csv = csv
    @date_from = date_from.to_date
    @date_to = date_to.to_date
    @income = 0
    @expense = 0
  end

  def calculate
    csv.each do |row|
      next unless between_dates?(row)

      if amount(row).positive?
        @income += amount(row)
      else
        @expense += amount(row)
      end
    end

    balance
  end

  private

  attr_reader :csv, :date_from, :date_to, :income, :expense

  def between_dates?(row)
    date_from <= row['Parsed date'] && row['Parsed date'] < date_to
  end

  def amount(row)
    row['Kwota'].to_f
  end

  def balance
    { income: income, expense: expense }
  end
end

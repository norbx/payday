class Balance
  def initialize(csv)
    @csv = csv
    @income = 0
    @expense = 0
  end

  def calculate
    csv.each do |row|
      amount(row).positive? ? @income += amount(row) : @expense += amount(row)
    end

    balance
  end

  private

  attr_reader :csv, :income, :expense

  def amount(row)
    row['Kwota'].to_f
  end

  def balance
    { income: income, expense: expense }
  end
end

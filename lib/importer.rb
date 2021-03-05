class Importer
  def initialize(csv)
    @csv = csv
  end

  def import
    expenses = csv.map do |row|
      Expense.new(
        transaction_date: transaction_date(row),
        amount: amount(row),
        description: description(row),
        localization: localization(row),
        referential_number: referential_number(row)
      )
    end

    Expense.import(expenses, on_duplicate_key_ignore: true)
  end

  private

  attr_reader :csv

  def transaction_date(row)
    row['Parsed date']
  end

  def amount(row)
    row['Kwota']
  end

  def description(row)
    row['Opis transakcji']
  end

  def localization(row)
    row['Lokalizacja']
  end

  def referential_number(row)
    row['Oryginalna kwota']
  end
end

class Importer
  def initialize(csv)
    @csv = csv
  end

  def import
    Expense.insert_all(expenses, unique_by: :duplicated_expense_index)
  end

  private

  attr_reader :csv

  def expenses
    csv.map do |row|
      {
        transaction_date: transaction_date(row),
        amount: amount(row),
        description: description(row),
        localization: localization(row),
        referential_number: referential_number(row),
        created_at: Time.current,
        updated_at: Time.current
      }
    end
  end

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
    row['Numer referencyjny']
  end
end

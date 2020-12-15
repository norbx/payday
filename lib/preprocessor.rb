class Preprocessor
  def initialize(csv)
    @csv = csv
  end

  def extract_dates
    csv.each_with_index do |row, i|
      next assign_date(row, parse(row['Data waluty'])) if first_date_missing?(row)
      next assign_date(row, csv[i - 1]['Parsed date']) if date_missing?(row)

      assign_date(row, parse(transaction_date(row).to_s))
    end
  end

  private

  attr_reader :csv

  def first_date_missing?(row)
    date_missing?(row) && row == csv[0]
  end

  def date_missing?(row)
    transaction_date(row).nil?
  end

  def first_row?(row)
    row == csv[0]
  end

  def assign_date(row, date)
    row['Parsed date'] = date
  end

  def parse(date)
    Date.parse(date)
  end

  def transaction_date(row)
    row['Data i czas transakcji']&.match(/\d{4}-\d{2}-\d{2}/)
  end
end

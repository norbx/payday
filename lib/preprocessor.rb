class Preprocessor
  def initialize(csv, date_from, date_to)
    @csv = csv
    @date_from = date_from.to_date
    @date_to = date_to.to_date
  end

  def extract_dates
    csv.each_with_index do |row, index|
      row['Parsed date'] = transaction_date(row, index).to_date
    end
    csv.delete_if { |row| !row_in_range?(row) }
  end

  private

  attr_reader :csv, :date_from, :date_to

  def transaction_date(row, index)
    return row['Data waluty']  if index.zero? && !matched_date(row)

    matched_date(row) || csv[index - 1]['Parsed date']
  end

  def matched_date(row)
    row['Data i czas transakcji']&.match(/\d{4}-\d{2}-\d{2}/)&.to_s
  end

  def row_in_range?(row)
    date_from <= row['Parsed date'] && row['Parsed date'] < date_to
  end
end

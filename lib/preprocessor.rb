class Preprocessor
  def initialize(csv, date_from, date_to)
    @csv = csv
    @date_from = date_from.to_date
    @date_to = date_to.to_date
  end

  def extract_dates
    csv.each do |row|
      row['Parsed date'] = matched_date(row) || row['Data waluty'].to_date
    end
    csv.delete_if { |row| !row_in_range?(row) }
  end

  private

  attr_reader :csv, :date_from, :date_to

  def matched_date(row)
    row['Data i czas transakcji']&.match(/\d{4}-\d{2}-\d{2}/)&.to_s&.to_date
  end

  def row_in_range?(row)
    date_from <= row['Parsed date'] && row['Parsed date'] < date_to
  end
end

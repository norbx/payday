class Preprocessor
  def initialize(csv)
    @csv = csv
  end

  def extract_dates
    csv.each do |row|
      row['Parsed date'] = matched_date(row) || row['Data waluty'].to_date
    end
  end

  private

  attr_reader :csv

  def matched_date(row)
    row['Data i czas transakcji']&.match(/\d{4}-\d{2}-\d{2}/)&.to_s&.to_date
  end

  def row_in_range?(row)
    date_from <= row['Parsed date'] && row['Parsed date'] < date_to
  end
end

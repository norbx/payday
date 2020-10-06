class FillTransactionDates
  def initialize(csv)
    @csv = csv
    @last_date = Date.parse(csv['Data waluty'][1])
  end

  def call
    parse_dates
    fill_empty_dates
  end

  private

  attr_reader :csv

  def parse_dates
    csv.each do |row|
      next if matched_date(row['Data i czas transakcji']).nil?

      row['Parsed date'] = Date.parse(matched_date(row['Data i czas transakcji']).to_s)
    end
  end

  def fill_empty_dates
    csv.each do |row|
      row['Parsed date'] = if matched_date(row['Data i czas transakcji']).nil?
                             @last_date
                           else
                             Date.parse(matched_date(row['Data i czas transakcji']).to_s)
                           end
      @last_date = row['Parsed date']
    end
  end

  def matched_date(date)
    date.match(/\d{4}-\d{2}-\d{2}/)
  end
end

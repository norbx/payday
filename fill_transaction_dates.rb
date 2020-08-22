class FillTransactionDates
  def initialize(csv)
    @csv = csv
    @last_date = csv[1]['Data waluty']
  end

  def call
    fill_dates
    csv
  end

  private

  attr_reader :csv

  def fill_dates
    csv.each do |row|
      if matched_date(row).nil?
        row['Data i czas transakcji'] = @last_date
      else
        row['Data i czas transakcji'] = matched_date(row).to_s
      end 
      @last_date = row['Data i czas transakcji']
    end
  end

  def matched_date(row)
    row['Data i czas transakcji'].match(/\d{4}-\d{2}-\d{2}/)
  end
end

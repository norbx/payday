class Categories
  CATEGORIES = %w[
    codzienne
    sport
    miasto
    leki
    pkp
    ztm
    bolt
    ciuchy
    rozrywka
    rachunki
    czynsz
    prezenty
    zus
    praca
    wynagrodzenie
    inne
  ].freeze

  def initialize(csv, date_from, date_to)
    @csv = csv
    @category = nil
    @report = {}
    @date_from = date_from.to_date
    @date_to = date_to.to_date
  end

  def categorize
    csv.each do |row|
      next unless between_dates?(row)

      print `clear`
      puts(row.map { |k, v| "#{k}: #{v}" })
      prompt_categories
      count_in_report(row)
      row['Category'] = @category
    end

    report
  end

  private

  def between_dates?(row)
    date_from <= row['Parsed date'] && row['Parsed date'] < date_to
  end

  def prompt_categories
    loop do
      @category = $stdin.gets.chomp.downcase
      break if CATEGORIES.include?(category)

      puts "Available categories: #{CATEGORIES.join(', ')}"
    end
  end

  def count_in_report(row)
    @report.key?(@category) ? @report[@category] += row['Kwota'].to_f : @report[@category] = row['Kwota'].to_f
  end

  attr_reader :csv, :category, :report, :date_from, :date_to
end

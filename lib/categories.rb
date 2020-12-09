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

  def initialize(csv, month)
    @csv = csv
    @category = nil
    @report = {}
    @month = month
  end

  def categorize
    csv.each do |row|
      print `clear`
      puts(row.map { |k, v| "#{k}: #{v}" })
      prompt_categories
      count_in_report(row)
      row['Category'] = @category
    end
    save_report
  end

  private

  def save_report
    report.each_pair do |category, value|
      MonthlyReport.create!(category: category, value: value, month: month, year: 2020)
    end
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

  attr_reader :csv, :category, :report, :month
end

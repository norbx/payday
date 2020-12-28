class Categories
  def initialize(csv)
    @csv = csv
    @printer = Printer.new
    @category = nil
  end

  def categorize
    csv.each do |row|
      printer.print_row(row, headers)
      row['Category'] = printer.prompt_until(categories)
    end
  end

  private

  attr_reader :csv, :category, :printer

  def categories
    @categories ||= Category.pluck(:name)
  end

  def headers
    ['Parsed date', 'Lokalizacja', 'Kwota']
  end
end

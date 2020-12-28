class Categories
  def initialize(csv)
    @csv = csv
    @category = nil
  end

  def categorize
    csv.each do |row|
      print `clear`
      puts(row.map { |k, v| "#{k}: #{v}" })
      prompt_categories
      row['Category'] = @category
    end
  end

  private

  attr_reader :csv, :category

  def prompt_categories
    loop do
      @category = $stdin.gets.chomp.downcase
      break if categories.include?(category)

      puts "Available categories: #{categories.join(', ')}"
    end
  end

  def categories
    @categories ||= Category.pluck(:name)
  end
end

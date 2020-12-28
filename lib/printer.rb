class Printer
  def print_row(row, headers)
    print `clear`
    row.map do |header, value|
      next unless headers.include?(header)

      puts "#{header}: #{value}"
    end
  end

  def prompt_until(valid_values)
    @value = $stdin.gets.chomp.downcase
    until valid_values.include?(@value)
      puts "Available values: #{valid_values.join(', ')}"
      @value = $stdin.gets.chomp.downcase
    end
    @value
  end
end

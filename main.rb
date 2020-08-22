require_relative 'config/application'

puts "Please provide file path for your monthly expenses: "
file_path = gets.chomp!

debugger

csv = ReadCSV.new(file_path).call
csv = FillTransactionDates.new(csv).call

puts "Please provide month number for expenses calculation: "
month = gets

expenses = GetMonthlyExpenses.new(csv, month).call

# csv.each_with_index { |row, i| puts "#{i}: #{row['Data i czas transakcji']}" }  

require './config'

csv = ReadCSV.new('wydatki.csv').call
csv = FillTransactionDates.new(csv).call

income, expenses = GetMonthlyReport.new(csv, 4).call

puts [income, expenses]

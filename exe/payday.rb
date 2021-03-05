require './config/database'
require './config/application'

load './db/seeds.rb'

puts 'Enter file path:'
file_path = gets.chomp

# puts 'Enter previous payday date:'
# date_from = gets.chomp
#
# puts 'Enter current payday date:'
# date_to = gets.chomp

data = Preprocessor.new(Reader.read_csv(file_path)).extract_dates

Importer.new(data).import

Reports.new(data, date_from: '2021-01-04', date_to: '2021-02-12').create_report

sh 'rake c'

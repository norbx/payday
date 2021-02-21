require './config/database'
require './config/application'

load './db/seeds.rb'

puts 'Enter file path:'
file_path = gets.chomp

puts 'Enter previous payday date:'
date_from = gets.chomp

puts 'Enter current payday date:'
date_to = gets.chomp

data = Preprocessor.new(Reader.read_csv(file_path), date_from, date_to).extract_dates

Reports.new(data, date_from: date_from, date_to: date_to).create_report

sh 'rake c'

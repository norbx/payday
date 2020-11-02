require './config/application'

reader = Reader
data_processor = DataProcessor.new(reader.read_csv('./wydatki.csv'))
reports = Reports.new(data_processor.process, 4)

income, expenses = reports.monthly_report

puts [income, expenses]

require './config/application'

data = DataProcessor.new(Reader.read_csv('./wydatki_short.csv')).process

Reports.new(data, 10, 2020).create_report

sh 'rake c'

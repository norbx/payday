require './config/application'

data = DataProcessor.new(Reader.read_csv('./wydatki_short.csv')).process

Reports.new(data, date_from: '2020-10-23', date_to: '2020-10-26').create_report

sh 'rake c'

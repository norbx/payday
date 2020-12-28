require './config/application'

data = Preprocessor.new(Reader.read_csv('./wydatki_short.csv'), '2020-10-23', '2020-10-26').extract_dates
sh 'rake db:seed'

Reports.new(data, date_from: '2020-10-23', date_to: '2020-10-26').create_report

sh 'rake c'

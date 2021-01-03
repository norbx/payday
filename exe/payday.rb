require './config/application'

data = Preprocessor.new(Reader.read_csv('./wydatki.csv'), '2020-11-10', '2020-12-10').extract_dates
sh 'rake db:seed'

Reports.new(data, date_from: '2020-11-10', date_to: '2020-12-10').create_report

sh 'rake c'

RSpec.shared_context 'Processed CSV', shared_context: :metadata do
  let(:csv) { Reader.read_csv('spec/fixtures/test.csv') }
  let(:processed_csv) { Preprocessor.new(csv, date_from, date_to).extract_dates }
  let(:date_from) { '2020-04-24' }
  let(:date_to) { '2020-04-29' }
end

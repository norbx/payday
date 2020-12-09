RSpec.shared_context 'Processed CSV', shared_context: :metadata do
  let(:csv) { Reader.read_csv('spec/fixtures/test.csv') }
  let(:processed_csv) { DataProcessor.new(csv).process }
end

require 'spec_helper'

RSpec.describe Reports do
  let(:csv) { Reader.read_csv('spec/fixtures/test.csv') }
  let(:data_processor) { DataProcessor.new(csv) }
  let(:processed_csv) { data_processor.process }

  let(:month) { 4 }

  subject { described_class.new(processed_csv, month) }

  describe '#monthly_report' do
    it 'returns an array' do
      expect(subject.monthly_report).to be_an(Array)
    end

    it 'returns monthly income and expenses' do
      expect(subject.monthly_report).to eq([110.0, -106.5])
    end

    context 'when given transaction from different month' do
      before { csv << ['', '', '', '115.00', '', '', '', '', '2020-05-24', '', '', ''] }

      it 'does not include the transaction' do
        expect(subject.monthly_report).to eq([110.0, -106.5])
      end
    end
  end
end

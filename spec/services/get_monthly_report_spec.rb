require 'spec_helper'

RSpec.describe GetMonthlyReport do
  let(:csv) { CSV.read('spec/fixtures/test.csv', headers: true, encoding: 'ISO8859-1') }
  let(:parsed_csv) { FillTransactionDates.new(csv).call }

  let(:month) { 5 }

  subject { GetMonthlyReport.new(parsed_csv, month).call }

  it 'returns an array' do
    expect(subject).to be_an(Array)
  end

  it 'returns monthly income and expenses' do
    expect(subject).to eq([25, -15])
  end

  context 'when given transaction from different month' do
    before { csv << ['2020-04-29', '100.0', 'Data i czas transakcji: 2020-04-29'] }

    it 'does not include the transaction' do
      expect(subject).to eq([25, -15])
    end
  end
end

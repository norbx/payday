require 'spec_helper'

RSpec.describe Preprocessor do
  let(:csv) { Reader.read_csv('./spec/fixtures/test.csv') }

  subject { described_class.new(csv).extract_dates }

  it 'returns a csv table' do
    expect(subject).to be_a(CSV::Table)
  end

  it 'fills the column with dates' do
    expect(subject['Parsed date']).to all(be_a(Date))
  end

  context 'when the first row transaction date is missing' do
    before { csv[0]['Data i czas transakcji'] = '' }

    it 'fills the first row transaction date with its currency date' do
      expect(subject[0]['Parsed date']).to eq(csv[0]['Data waluty'].to_date)
    end
  end

  context 'when transaction date is missing' do
    before { csv[3]['Data i czas transakcji'] = '' }

    it 'fills the parsed date with currency date' do
      expect(subject[3]['Parsed date']).to eq(csv[3]['Data waluty'].to_date)
    end
  end
end

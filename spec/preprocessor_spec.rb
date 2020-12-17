require 'spec_helper'

RSpec.describe Preprocessor do
  let(:csv) { Reader.read_csv('./spec/fixtures/test.csv') }

  let(:date_from) { '2020-04-24' }
  let(:date_to) { '2020-04-29' }

  subject { described_class.new(csv, date_from, date_to) }

  describe '.extract_dates' do
    it 'returns a csv table' do
      expect(subject.extract_dates).to be_a(CSV::Table)
    end

    it 'returns all rows in given date range' do
      expect(subject.extract_dates.count).to eq(6)
    end

    it 'adds a column' do
      expect { subject.extract_dates }.to change { csv.headers.count }.by(1)
      expect(csv.headers.last).to eq('Parsed date')
    end

    it 'fills the column with dates' do
      expect(subject.extract_dates['Parsed date']).to all(be_a(Date))
    end

    context 'when records are not in date_from and date_to range' do
      let(:date_from) { '2020-04-25' }

      it 'deletes the irrelevant rows' do
        expect { subject.extract_dates }.to change { csv.count }.by(-3)
      end
    end

    context 'when the first row transaction date is missing' do
      before { csv[0]['Data i czas transakcji'] = '' }

      it 'fills the first row transaction date with its currency date' do
        expect(subject.extract_dates[0]['Parsed date']).to eq(csv[0]['Data waluty'].to_date)
      end
    end

    context 'when transaction date is missing' do
      before { csv[3]['Data i czas transakcji'] = '' }

      it 'fills the row transaction date with transaction date from previous row' do
        expect(subject.extract_dates[3]['Parsed date']).to eq(csv[2]['Parsed date'])
      end
    end
  end
end

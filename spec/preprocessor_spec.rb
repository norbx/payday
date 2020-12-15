require 'spec_helper'

RSpec.describe Preprocessor do
  let(:csv) { Reader.read_csv('./spec/fixtures/test.csv') }

  subject { described_class.new(csv) }

  describe '.extract_dates' do
    it 'adds a column' do
      expect { subject.extract_dates }.to change { csv.headers.count }.by(1)
    end

    it 'fills the column with dates' do
      expect(subject.extract_dates['Parsed date']).to all(be_a(Date))
    end

    context 'when Data i czas transakcji has missing cells' do
      before { csv[3]['Data i czas transakcji'] = '' }

      it 'fills Parsed date with previous Parsed date' do
        expect(subject.extract_dates[3]['Parsed date']).to eq(csv[2]['Parsed date'])
      end
    end
  end
end

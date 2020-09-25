require 'spec_helper'

RSpec.describe FillTransactionDates do
  let(:csv) { CSV.read('spec/fixtures/test.csv', headers: true, encoding: 'ISO8859-1') }

  subject { described_class.new(csv).call }

  it 'adds a column' do
    expect { subject }.to change { csv.headers.count }.by(1)
  end

  it 'fills the column with dates' do
    expect(subject['Parsed date']).to all(be_a(Date))
  end

  context 'when Data i czas transakcji has missing cells' do
    before { csv << ['2020-04-29', '10.0', ''] }

    it 'fills Parsed date with previous Parsed date' do
      expect(subject['Parsed date'][3]).to eq(csv['Parsed date'][2])
    end
  end
end

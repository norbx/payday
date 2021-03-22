require 'spec_helper'
require 'stringio'

RSpec.describe Categories do
  include_context 'Processed CSV'

  let(:row) { processed_csv[2] }
  let(:value) { 'bonus' }

  before do
    create(:category, name: 'bonus')
    create(:category, name: 'codzienne')
  end

  subject { described_class.categorize(row, value) }

  it 'returns the row' do
    expect(subject).to be_a(CSV::Row)
  end

  it 'adds new column' do
    expect { subject }.to change { row.headers.size }.by(1)
  end

  it 'assigns value to a rows category field' do
    subject

    expect(row['category']).to eq(value)
  end

  context 'when the value is not included in categories' do
    let(:value) { 'invalid' }

    it 'returns nil' do
      expect(subject).to be_nil
    end
  end
end

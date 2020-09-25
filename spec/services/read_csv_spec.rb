require 'spec_helper'

RSpec.describe ReadCSV do
  let(:path) { './spec/fixtures/test.csv' }

  subject { described_class.new(path).call }

  it 'reads a csv file' do
    expect(subject).to be_a(CSV::Table)
  end

  it 'sets headers' do
    expect(subject.headers.count).to eq(11)
  end
end

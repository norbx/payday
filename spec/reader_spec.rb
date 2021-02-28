require 'spec_helper'

RSpec.describe Reader do
  let(:path) { './spec/fixtures/test.csv' }

  subject { described_class.read_csv(path) }

  it 'reads a csv file' do
    expect(subject).to be_a(CSV::Table)
  end

  it 'sets headers' do
    expect(subject.headers.compact.count).to eq(12)
  end
end

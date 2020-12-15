require 'spec_helper'

RSpec.describe Reader do
  let(:path) { './spec/fixtures/test.csv' }

  subject { described_class }

  describe '#read_csv' do
    it 'reads a csv file' do
      expect(subject.read_csv(path)).to be_a(CSV::Table)
    end

    it 'sets headers' do
      expect(subject.read_csv(path).headers.count).to eq(12)
    end
  end
end

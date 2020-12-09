require 'spec_helper'

RSpec.describe Categories do
  include_context 'Processed CSV'

  let(:month) { 4 }

  subject { described_class.new(processed_csv, month) }

  describe '.categorize' do
    before { allow($stdin).to receive(:gets).and_return('sport') }

    it 'adds new column' do
      expect { subject.categorize }.to change { processed_csv.headers.size }.by(1)
    end

    it 'returns a hash' do
      expect(subject.categorize).to be_a(Hash)
    end

    it 'returns categorized expenses' do
      expect(subject.categorize).to have_key('sport')
    end

    it 'sums expenses for each category' do
      expect(subject.categorize['sport']).to eq(3.5)
    end
  end
end

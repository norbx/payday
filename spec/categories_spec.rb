require 'spec_helper'
require 'stringio'

RSpec.describe Categories do
  include_context 'Processed CSV'

  let(:printer) { double(Printer) }

  before { allow(printer).to receive(:print_row) }
  before { allow(printer).to receive(:prompt_until).and_return('sport') }

  subject { described_class.new(processed_csv, printer: printer) }

  describe '.categorize' do
    it 'adds new column' do
      expect { subject.categorize }.to change { processed_csv.headers.size }.by(1)
    end

    it 'returns a hash' do
      expect(subject.categorize).to be_a(CSV::Table)
    end

    it 'returns categorized expenses' do
      expect(subject.categorize.headers).to include('Category')
    end

    it 'sums expenses for each category' do
      expect(subject.categorize['sport']).to be_an(Array)
    end
  end
end

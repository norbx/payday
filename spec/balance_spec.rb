require 'spec_helper'

RSpec.describe Balance do
  include_context 'Processed CSV'

  let(:date_from) { '2020-04-24' }
  let(:date_to) { '2020-04-29' }

  subject { described_class.new(processed_csv, date_from, date_to).calculate }

  describe '.calculate' do
    it 'calculates total income' do
      expect(subject[:income]).to eq(110)
    end

    it 'calculates total expense' do
      expect(subject[:expense]).to eq(-106.5)
    end

    context 'when given transaction from different month' do
      before { csv << ['', '', '', '115.00', '', '', '', '', '2020-05-24', '', '', ''] }

      it 'does not change total income' do
        expect(subject[:income]).to eq(110)
      end

      it 'does not change total expense' do
        expect(subject[:expense]).to eq(-106.5)
      end
    end

    context 'when given transaction that occurs at date_to' do
      before { csv << ['', '', '', '115.00', '', '', '', '', '2020-04-29', '', '', ''] }

      it 'does not change total income' do
        expect(subject[:income]).to eq(110)
      end

      it 'does not change total expense' do
        expect(subject[:expense]).to eq(-106.5)
      end
    end
  end
end

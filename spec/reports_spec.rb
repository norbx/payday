require 'spec_helper'

RSpec.describe Reports do
  include_context 'Processed CSV'

  let(:month) { 4 }
  let(:year) { 11 }

  subject { described_class.new(processed_csv, month, year) }

  describe '.create_report' do
    before { allow($stdin).to receive(:gets).and_return('sport') }

    it 'creates a monthly report' do
      expect { subject.create_report }.to change { MonthlyReport.count }.by(1)
    end

    it 'creates categories provided by the user' do
      expect { subject.create_report }.to change { Category.count }.by(1)
    end

    context 'for the given month' do
      before { subject.create_report }

      it 'calculates total income' do
        expect(MonthlyReport.last.income).to eq(110)
      end

      it 'calculates total expense' do
        expect(MonthlyReport.last.expense).to eq(-106.5)
      end

      context 'when given transaction from different month' do
        before { csv << ['', '', '', '115.00', '', '', '', '', '2020-05-24', '', '', ''] }

        it 'does not change total income' do
          expect(MonthlyReport.last.income).to eq(110)
        end

        it 'does not change total expense' do
          expect(MonthlyReport.last.expense).to eq(-106.5)
        end
      end
    end
  end
end

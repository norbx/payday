require 'spec_helper'

RSpec.describe Reports do
  include_context 'Processed CSV'

  let(:date_from) { '2020-04-24' }
  let(:date_to) { '2020-04-29' }

  subject { described_class.new(processed_csv, date_from: date_from, date_to: date_to) }

  describe '.create_report' do
    before { allow($stdin).to receive(:gets).and_return('sport') }

    it 'creates a monthly report' do
      expect { subject.create_report }.to change { MonthlyReport.count }.by(1)
    end

    it 'creates categories provided by the user' do
      expect { subject.create_report }.to change { Expense.count }.by(6)
    end
  end
end

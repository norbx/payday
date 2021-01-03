require 'spec_helper'

RSpec.describe Reports do
  include_context 'Processed CSV'

  let(:categories) { double(Categories) }
  let(:categories_instance) { Categories.new(processed_csv) }

  before { allow(categories).to receive(:new).with(processed_csv).and_return(categories_instance) }
  before { allow(categories_instance).to receive(:categorize).and_return(processed_csv) }

  subject { described_class.new(processed_csv, categories: categories, date_from: date_from, date_to: date_to) }

  describe '.create_report' do
    it 'creates a monthly report' do
      expect { subject.create_report }.to change { MonthlyReport.count }.by(1)
    end

    it 'creates categories provided by the user' do
      expect { subject.create_report }.to change { Expense.count }.by(6)
    end
  end
end

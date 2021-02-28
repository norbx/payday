require 'spec_helper'

RSpec.describe Reports do
  include_context 'Processed CSV'

  let(:categories) { double(Categories) }
  let(:categories_instance) { Categories.new(processed_csv) }

  before { allow(categories).to receive(:new).with(processed_csv).and_return(categories_instance) }
  before { allow(categories_instance).to receive(:categorize).and_return(processed_csv) }

  subject { described_class.new(processed_csv, categories: categories, date_from: '2020-04-25', date_to: '2020-04-29') }

  describe '.create_report' do
    it 'creates a monthly report' do
      expect { subject.create_report }.to change { MonthlyReport.count }.by(1)
    end
  end
end

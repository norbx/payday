require "rails_helper"
RSpec.describe ImportExpenses do
  subject { described_class.call(csv_file, filename) }

  context 'when mbank csv is supplied' do
    let(:csv_file) { fixture_file_upload('spec/fixtures/mbank_expenses.csv', 'text/csv') }
    let(:filename) { 'mbank_expenses.csv' }

    it 'imports expenses from a csv file' do
      expect { subject }.to change { Expense.count }.by(3)

      import = ExpensesImport.last
      expect(import.file_name).to eq(filename)
      expect(import.state).to eq('completed')
    end
  end

  context "when pkobp csv is supplied" do
    let(:csv_file) { fixture_file_upload('spec/fixtures/pkobp_expenses.csv', 'text/csv') }
    let(:filename) { 'pkobp_expenses.csv' }

    it 'imports expenses from a csv file' do
      expect { subject }.to change { Expense.count }.by(3)

      import = ExpensesImport.last
      expect(import.file_name).to eq(filename)
      expect(import.state).to eq('completed')
    end
  end

  it 'raises an error for unsupported formats' do
    invalid_csv_file = fixture_file_upload('spec/fixtures/invalid_expenses.csv', 'text/csv')
    service = ImportExpenses.new(invalid_csv_file, 'invalid_expenses.csv')

    expect { service.call }.to raise_error(I18n.t("imports.unsupported_format"))
  end
end

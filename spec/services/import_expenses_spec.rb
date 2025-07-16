require "rails_helper"
RSpec.describe ImportExpenses do
  subject { described_class.call(csv_file, filename) }

  let(:category) { create(:category, name: "Some Category") }

  let!(:subcategory1) { create(:subcategory, name: "Prąd", category:) }
  let!(:subcategory2) { create(:subcategory, name: "Żywność i chemia domowa", category:) }
  let!(:subcategory3) { create(:subcategory, name: "Jedzenie poza domem", category:) }

  context 'when mbank csv is supplied' do
    let(:csv_file) { fixture_file_upload('spec/fixtures/mbank_expenses.csv', 'text/csv') }
    let(:filename) { 'mbank_expenses.csv' }


    it 'imports expenses from a csv file' do
      expect { subject }.to change { ExpensesImport.count }.by(1).and change { Expense.count }.by(3)

      import = ExpensesImport.last
      expect(import.file_name).to eq(filename)
      expect(import.state).to eq('completed')
      expect(import.expenses.pluck(:category_id)).to match_array([ category.id, category.id, category.id ])
      expect(import.expenses.pluck(:subcategory_id)).to match_array([ subcategory1.id, subcategory2.id, subcategory3.id ])
    end
  end

  context "when pkobp csv is supplied" do
    let(:csv_file) { fixture_file_upload('spec/fixtures/pkobp_expenses.csv', 'text/csv') }
    let(:filename) { 'pkobp_expenses.csv' }

    it 'imports expenses from a csv file and maps them to correct subcategories' do
      expect { subject }.to change { ExpensesImport.count }.by(1).and change { Expense.count }.by(3)

      import = ExpensesImport.last
      expect(import.file_name).to eq(filename)
      expect(import.state).to eq('completed')
      expect(import.expenses.pluck(:category_id)).to match_array([ category.id, category.id, category.id ])
      expect(import.expenses.pluck(:subcategory_id)).to match_array([ subcategory1.id, subcategory2.id, subcategory3.id ])
    end
  end

  it 'raises an error for unsupported formats' do
    invalid_csv_file = fixture_file_upload('spec/fixtures/invalid_expenses.csv', 'text/csv')
    service = ImportExpenses.new(invalid_csv_file, 'invalid_expenses.csv')

    expect { service.call }.to raise_error(I18n.t("imports.unsupported_format"))
  end
end

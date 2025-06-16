require 'rails_helper'

RSpec.describe 'Import Expenses', type: :system do
  let(:csv_file) { fixture_file_upload('spec/fixtures/expenses.csv', 'text/csv') }

  it 'imports expenses from a CSV file' do
    visit imports_path

    attach_file('file_input', csv_file.path)
    click_button 'Import'

    expect(page).to have_content('Plik przesłany pomyślnie.')
    expect(Expense.count).to eq(3)
  end

  it 'shows an error when no file is selected' do
    visit imports_path

    click_button 'Import'

    expect(page).to have_content('Brak pliku do przesłania.')
  end
end

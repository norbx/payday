require 'rails_helper'

RSpec.describe 'Import Expenses', type: :system, js: true do
  let(:csv_file) { fixture_file_upload('spec/fixtures/mbank_expenses.csv', 'text/csv') }

  before { driven_by(:selenium_chrome_headless) }
  before do
    create(:subcategory, name: "Prąd")
    create(:subcategory, name: "Żywność i chemia domowa")
    create(:subcategory, name: "Jedzenie poza domem")
  end

  it 'imports expenses from a CSV file' do
    visit imports_path

    attach_file('file_input', csv_file.path)
    click_button 'Import CSV'

    expect(page).to have_content('Plik przesłany pomyślnie.')
    expect(Expense.count).to eq(3)
  end

  it 'shows an error when no file is selected' do
    visit imports_path

    click_button 'Import CSV'

    expect(page).to have_content('Brak pliku do przesłania.')
  end
end

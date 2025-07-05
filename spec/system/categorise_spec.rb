require 'rails_helper'

RSpec.describe "Categorise expenses", type: :system, js: true do
  let!(:category1) { create(:category, name: "Food") }
  let!(:category2) { create(:category, name: "Transport") }
  let!(:import) { create(:expenses_import) }
  let!(:expense1) { create(:expense, description: "Lunch", amount: 10, date: Date.today, expenses_import: import, category: nil) }
  let!(:expense2) { create(:expense, description: "Bus", amount: 3, date: Date.today, expenses_import: import, category: nil) }

  before do
    driven_by(:selenium_chrome_headless)
  end

  it "shows the first expense and categories, and assigns a category" do
    visit categorise_path
    expect(page).to have_content("Lunch")
    expect(page).to have_button("Food")
    expect(page).to have_button("Transport")

    click_button "Food"
    click_button "Submit expenses"

    expect(page).to have_content("Bus")
    expect(expense1.reload.category).to eq(category1)
  end

  it "categorises all expenses and shows completion message" do
    visit categorise_path
    click_button "Food"
    click_button "Transport"
    expect(page).to have_content("All 2 expenses categorised.")
  end
end

require 'rails_helper'

RSpec.describe "Categorise expenses", type: :system, js: true do
  let!(:category1) { create(:category, name: "Food") }
  let!(:category2) { create(:category, name: "Transport") }
  let!(:import) { create(:expenses_import) }
  let!(:expense1) { create(:expense, description: "Lunch", amount: 10, date: Date.today, expenses_import: import, category: nil) }
  let!(:expense2) { create(:expense, description: "Bus", amount: 3, date: Date.today, expenses_import: import, category: nil) }

  before do
    driven_by(:selenium_chrome_headless)

    visit categorise_path

    expect(page).to have_content("Lunch")
    expect(page).to have_button("Food")
    expect(page).to have_button("Transport")
  end

  it "shows the first expense and categories, and assigns a category" do
    click_button "Food"
    click_button "Zapisz"

    expect(page).to have_content("Bus")
    expect(expense1.reload.category).to eq(category1)
  end

  it "categorises all expenses and shows completion message" do
    click_button "Food"

    expect(page).to have_content("Bus")
    click_button "Transport"

    expect(page).to have_content("Wszystkie 2 wydatków skategoryzowane, brawo!")
  end

  it "navigates through expenses using next and previous buttons" do
    find('[data-testid="next-button"]').click
    expect(page).to have_content("Bus")
    expect(page).not_to have_content("Lunch")

    find('[data-testid="previous-button"]').click
    expect(page).to have_content("Lunch")
    expect(page).not_to have_content("Bus")
  end
end

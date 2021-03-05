require 'spec_helper'

RSpec.describe Importer do
  include_context 'Processed CSV'

  subject { described_class.new(processed_csv).import }

  it 'imports rows' do
    expect { subject }.to change(Expense, :count).by(6)
  end

  it 'imports all necessary data' do
    expenses = Expense.all

    subject

    expect(expenses.all? { |e| e.transaction_date.present? }).to be(true)
    expect(expenses.all? { |e| e.amount.present? }).to be(true)
    expect(expenses.all? { |e| e.description.present? }).to be(true)
    expect(expenses.all? { |e| e.localization.present? }).to be(true)
  end

  context 'when the row amount, description, localization and transaction_date are not unique' do
    before do
      transaction_date = processed_csv[-1]['Parsed date']
      description = processed_csv[-1]['Opis transakcji']
      localization = processed_csv[-1]['Lokalizacja']
      amount = processed_csv[-1]['Kwota']
      row =  CSV::Row.new(
        ['Parsed date', 'Opis transakcji', 'Kwota', 'Lokalizacja'],
        [transaction_date, description, amount, localization]
      )

      processed_csv << row
    end

    it 'does not save duplicated rows' do
      expect { subject }.to change(Expense, :count).by(6)
    end
  end
end

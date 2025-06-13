class AddExpensesImportsReferencesToExpenses < ActiveRecord::Migration[8.0]
  def change
    add_reference :expenses, :expenses_import, null: true, foreign_key: { to_table: :expenses_imports }
  end
end

class RemoveImportedAtFromExpensesImport < ActiveRecord::Migration[8.0]
  def change
    remove_column :expenses_imports, :imported_at, :date
  end
end

class CreateExpensesImports < ActiveRecord::Migration[8.0]
  def change
    create_table :expenses_imports do |t|
      t.date :imported_at, null: false
      t.string :state, null: false, default: 'pending'
      t.string :file_name, null: false

      t.timestamps
    end
  end
end

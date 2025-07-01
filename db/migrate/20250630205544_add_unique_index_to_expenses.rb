class AddUniqueIndexToExpenses < ActiveRecord::Migration[8.0]
  def change
    add_index :expenses, [ :date, :description, :amount ],
      unique: true,
      name: 'expenses_unique_index'
  end
end

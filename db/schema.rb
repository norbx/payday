ActiveRecord::Schema.define do
  create_table :reports, force: true do |t|
    t.date :from
    t.date :to
    t.timestamps
  end

  create_table :categories, force: true do |t|
    t.string :name
    t.timestamps
  end

  create_table :expenses, force: true do |t|
    t.date :transaction_date
    t.decimal :amount, precision: 8, scale: 2, default: 0.0
    t.string :description
    t.string :localization
    t.string :referential_number
    t.references :category
    t.references :report
    t.timestamps
  end

  add_index :expenses, %i[transaction_date amount localization description referential_number],
            name: 'duplicated_expense_index', unique: true
end

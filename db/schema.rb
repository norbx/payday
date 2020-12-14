require './config/application'

ActiveRecord::Schema.define do
  create_table :monthly_reports, force: true do |t|
    t.integer :month
    t.integer :year
    t.decimal :income, precision: 8, scale: 2, default: 0.0
    t.decimal :expense, precision: 8, scale: 2, default: 0.0
    t.timestamps
  end

  create_table :categories, force: true do |t|
    t.references :monthly_report
    t.string :name
    t.decimal :amount, precision: 8, scale: 2, default: 0.0
    t.timestamps
  end
end

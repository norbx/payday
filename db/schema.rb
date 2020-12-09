require './config/application'

ActiveRecord::Schema.define do
  create_table :monthly_reports, force: true do |t|
    t.integer :month
    t.integer :year
    t.string :category
    t.decimal :value, precision: 8, scale: 2, default: 0.0
  end

  create_table :categories, force: true do |t|
    t.string :name
  end
end

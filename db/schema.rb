require './config/application'

ActiveRecord::Schema.define do
  create_table :expenses, force: true do |t|
    t.string :month
    t.decimal :amount, precision: 8, scale: 2, default: 0.0
  end
end

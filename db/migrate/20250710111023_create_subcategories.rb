class CreateSubcategories < ActiveRecord::Migration[8.0]
  def change
    create_table :subcategories do |t|
      t.string :name, null: false
      t.references :category, null: true, foreign_key: true

      t.timestamps
    end
  end
end

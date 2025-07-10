class Category < ApplicationRecord
  has_many :expenses
  has_many :subcategories, dependent: :destroy
end

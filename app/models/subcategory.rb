class Subcategory < ApplicationRecord
  has_many :expenses, dependent: :nullify

  belongs_to :category

  validates :name, presence: true, uniqueness: { scope: :category_id }

  def self.find_by_name(name:)
    find_by!(name:)
  rescue ActiveRecord::RecordNotFound
    Rails.logger.warn("Subcategory not found for name: #{name}. Using default subcategory.")
    find_by!(name: "Bez kategorii")
  end
end

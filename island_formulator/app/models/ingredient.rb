class Ingredient < ApplicationRecord
  belongs_to :user
  has_many :ingredient_tags, dependent: :destroy
  has_many :tags, through: :ingredient_tags
  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients
  has_many :inventory_items, dependent: :destroy

  validates :name, presence: true
  validates :category, presence: true
  validates :user, presence: true

  has_one_attached :photo
end

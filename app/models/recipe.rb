class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :recipe_categories
  has_many :categories, through: :recipe_categories
  has_many :ratings
end

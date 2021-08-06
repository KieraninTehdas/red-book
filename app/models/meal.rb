class Meal < ApplicationRecord
  belongs_to :recipe_book, optional: true
  has_many :meal_plan_meals
  has_many :meal_plans, through: :meal_plan_meals
  validates :page_number, absence: true, numericality: { only_integer: true }, unless: -> { recipe_book.present? }

  def recipe_book_name
    recipe_book&.name
  end
end

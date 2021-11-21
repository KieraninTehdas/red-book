# frozen_string_literal: true

class Meal < ApplicationRecord
  belongs_to :recipe_book, optional: true

  has_many :meal_plan_meals
  has_many :meal_plans, through: :meal_plan_meals

  validates :name, presence: true
  validates :page_number, numericality: { only_integer: true, allow_nil: true }
  validates :recipe_book, presence: true, if: -> { page_number.present? }

  def recipe_book_name
    recipe_book&.name
  end
end

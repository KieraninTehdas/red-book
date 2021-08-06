class MealPlan < ApplicationRecord
  has_many :meal_plan_meals
  has_many :meals, through: :meal_plan_meals
end

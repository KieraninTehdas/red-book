# frozen_string_literal: true

class RecipeBook < ApplicationRecord
  has_many :meals, dependent: :nullify

  def disassociate_meals
    meals.each do |meal|
      meal.recipe_book = nil
      meal.page_number = nil
      meal.save
    end
  end
end

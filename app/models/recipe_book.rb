class RecipeBook < ApplicationRecord
  has_many :meals

  def disassociate_meals
    meals.each do |meal|
      meal.recipe_book = nil
      meal.page_number = nil
      meal.save
    end
  end
end

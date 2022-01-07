# frozen_string_literal: true

module MealPlansHelper
  def plan_meal_url(plan_meal_id)
    # TODO: hostname should be set dynamically
    "http://localhost:3000/meal-plan-meals/#{plan_meal_id}"
  end
end

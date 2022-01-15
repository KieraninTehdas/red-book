# frozen_string_literal: true

class MealPlanMealsController < ApplicationController
  def update_eaten_status
    plan_meal = MealPlanMeal.find(params[:id])

    plan_meal.update!(eaten: params[:updated_value])

    respond_to do |format|
      format.json
      format.js
    end
  end
end

class AddEatenToMealPlanMeals < ActiveRecord::Migration[6.1]
  def change
    add_column :meal_plan_meals, :eaten, :boolean, default: false
  end
end

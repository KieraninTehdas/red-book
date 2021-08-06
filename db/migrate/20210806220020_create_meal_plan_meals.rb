class CreateMealPlanMeals < ActiveRecord::Migration[6.1]
  def change
    create_table :meal_plan_meals do |t|

      t.timestamps
    end
  end
end

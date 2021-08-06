class CreateMealPlanMealTable < ActiveRecord::Migration[6.1]
  def change
    create_table :meal_plan_meals do |t|
      t.integer :meal_plan_id
      t.integer :meal_id
      t.timestamps
    end
  end
end

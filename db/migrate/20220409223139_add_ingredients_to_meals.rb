class AddIngredientsToMeals < ActiveRecord::Migration[6.1]
  def change
    add_column :meals, :ingredients, :text
  end
end

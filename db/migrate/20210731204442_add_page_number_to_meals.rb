class AddPageNumberToMeals < ActiveRecord::Migration[6.1]
  def change
    add_column :meals, :page_number, :integer
  end
end

# frozen_string_literal: true

class AddRecipeBookRefToMeals < ActiveRecord::Migration[6.1]
  def change
    add_reference :meals, :recipe_book, null: true, foreign_key: true
  end
end

# frozen_string_literal: true

class CreateRecipeBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_books do |t|
      t.string :name

      t.timestamps
    end
  end
end

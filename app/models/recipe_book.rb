# frozen_string_literal: true

class RecipeBook < ApplicationRecord
  before_destroy { |book| Meal.where(recipe_book: book).update_all(page_number: nil) }

  has_many :meals, dependent: :nullify

  validates :name, presence: true
end

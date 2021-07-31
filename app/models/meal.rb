class Meal < ApplicationRecord
  belongs_to :recipe_book, optional: true
end

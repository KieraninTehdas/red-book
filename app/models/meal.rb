class Meal < ApplicationRecord
  belongs_to :recipe_book, optional: true
  validates :page_number, absence: true, unless: -> { recipe_book.present? }
end

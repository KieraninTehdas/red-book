# frozen_string_literal: true

json.array! @recipe_books, partial: 'recipe_books/recipe_book', as: :recipe_book

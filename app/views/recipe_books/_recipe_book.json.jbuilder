json.extract! recipe_book, :id, :name, :created_at, :updated_at
json.url recipe_book_url(recipe_book, format: :json)

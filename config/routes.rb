Rails.application.routes.draw do
  resources :recipe_books, :path => '/recipe-books'
  resources :meals
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

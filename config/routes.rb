# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'meal_plans#index'
  resources :meal_plans, path: '/meal-plans'
  resources :recipe_books, path: '/recipe-books'
  resources :meals
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

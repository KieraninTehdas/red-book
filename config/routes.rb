# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'meal_plans#index'
  resources :meal_plans, path: '/meal-plans' do
    collection do
      get 'past', to: 'meal_plans#past_meal_plans'
    end
    member do
      get 'shopping-list', to: 'meal_plans#generate_shopping_list'
    end
  end
  resources :recipe_books, path: '/recipe-books' do
    collection do
      get 'search', to: 'recipe_books#search'
    end
  end
  resources :meals

  patch 'meal-plan-meals/:id', to: 'meal_plan_meals#update_eaten_status'
end

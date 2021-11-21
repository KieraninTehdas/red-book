# frozen_string_literal: true

json.array! @meal_plans, partial: 'meal_plans/meal_plan', as: :meal_plan

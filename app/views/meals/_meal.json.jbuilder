# frozen_string_literal: true

json.extract! meal, :id, :name, :created_at, :updated_at
json.url meal_url(meal, format: :json)

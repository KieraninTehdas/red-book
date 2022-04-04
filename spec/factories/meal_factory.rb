# frozen_string_literal: true

FactoryBot.define do
  factory :meal do
    name { 'Spaghetti' }

    trait :with_recipe_book do
      association :recipe_book, factory: :recipe_book
      page_number { 55 }
    end
  end
end

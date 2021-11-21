# frozen_string_literal: true

FactoryBot.define do
  factory :meal_plan do
    start_date { Date.today - 7 }
    end_date { Date.today }
  end
end

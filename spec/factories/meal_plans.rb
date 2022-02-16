# frozen_string_literal: true

FactoryBot.define do
  factory :meal_plan do
    start_date { Time.zone.today - 7 }
    end_date { Time.zone.today }
  end
end

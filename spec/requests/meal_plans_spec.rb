# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Meal Plans', type: :request do
  let(:meal) { create(:meal) }
  let(:start_date) { 4.days.ago }
  let(:end_date) { 2.days.from_now }

  describe '#create' do
    it 'creates a meal plan' do
      initial_plan_count = MealPlan.count

      post meal_plans_url,
           params: { meal_plan: { **date_to_date_select_param(start_date, :start_date),
                                  **date_to_date_select_param(end_date, :end_date), meal_ids: [meal.id] } }

      expect(MealPlan.count).to eq(initial_plan_count + 1)
    end
  end

  def date_to_date_select_param(date, param_name)
    { "#{param_name}(1i)": date.year, "#{param_name}(2i)": date.month, "#{param_name}(3i)": date.day }
  end
end

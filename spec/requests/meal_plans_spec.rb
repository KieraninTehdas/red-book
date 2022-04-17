# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Meal Plans', type: :request do
  let!(:meal) { create(:meal) }
  let(:start_date) { 4.days.ago }
  let(:end_date) { 2.days.from_now }
  let(:params) do
    { meal_plan: { **date_to_date_select_param(start_date, :start_date),
      **date_to_date_select_param(end_date, :end_date),
      meal_ids: [meal.id] } }
  end

  describe '#create' do
    it 'saves a new meal plan' do
      expect { post meal_plans_url, params: params }.to change(MealPlan, :count).by(1)
    end

    it 'redirects to index' do
      post meal_plans_url, params: params

      expect(response).to redirect_to MealPlan.last
      expect(flash[:notice]).to eq('Meal plan was created successfully')
    end

    it 'creates expected meal plan meals' do
      initial_meal_plan_meal_count = MealPlanMeal.count
      initial_meal_count = Meal.count

      post meal_plans_url, params: params

      expect(MealPlanMeal.count).to eq(initial_meal_plan_meal_count + 1)
      expect(Meal.count).to eq(initial_meal_count)
    end

    context 'when params are invalid' do
      let(:params) do
        { meal_plan: { **date_to_date_select_param(start_date, :end_date),
          **date_to_date_select_param(end_date, :start_date),
          meal_ids: [meal.id] } }
      end

      it "doesn't save a new meal plan" do
        expect { post meal_plans_url, params: params }.not_to change(MealPlan, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '#generate_shopping_list' do
    it 'joins and de-duplicates ingredients' do
      a_meal = build(:meal)
      a_meal.ingredients = "pepper\r\nsalt\r\nbread"
      another_meal = build(:meal)
      another_meal.ingredients = "pepper\r\ncarrots 100g\r\nmince ~500g"
      meal_plan = create(:meal_plan)
      meal_plan.update!(meals: [a_meal, another_meal])

      get shopping_list_meal_plan_path(meal_plan)

      expect(response.body).to eq([a_meal.ingredients, another_meal.ingredients].join("\n").to_json)
    end
  end

  def date_to_date_select_param(date, param_name)
    { "#{param_name}(1i)": date.year, "#{param_name}(2i)": date.month, "#{param_name}(3i)": date.day }
  end
end

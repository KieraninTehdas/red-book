# frozen_string_literal: true

class MealPlansController < ApplicationController
  before_action :set_meal_plan, only: %i[show edit update destroy]
  before_action :available_meals, only: %i[create edit]

  def index
    @meal_plans = MealPlan.all
    @current_meal_plan = MealPlan.current.first || MealPlan.last
  end

  def show; end

  def new
    @meal_plan = MealPlan.new
  end

  def edit; end

  def create
    @meal_plan = MealPlan.new(start_date: date_param_to_date(:start_date),
                              end_date: date_param_to_date(:end_date),
                              meal_ids: meal_plan_params.fetch(:meal_ids, []))

    unless @meal_plan.valid?
      render :new
      return
    end

    @meal_plan.save

    redirect_to @meal_plan, notice: 'Meal plan was created successfully'
  end

  def update
    @meal_plan.update!(meal_plan_params)

    redirect_to @meal_plan, notice: 'Meal plan was successfully updated.'
  end

  def past_meal_plans
    @past_meal_plans = MealPlan.past.order(end_date: :desc)
  end

  def destroy
    @meal_plan.destroy!
    format.html { redirect_to meal_plans_url, notice: 'Meal plan was successfully destroyed.' }
  end

  private

  def set_meal_plan
    @meal_plan = MealPlan.find(params[:id])
  end

  def available_meals
    @available_meals = Meal.all
  end

  def meal_plan_params
    params.require(:meal_plan).permit(:start_date, :end_date, meal_ids: [])
  end

  def date_param_to_date(param_name)
    date_components = %w[1 2 3].map { |e| meal_plan_params["#{param_name}(#{e}i)"].to_i }
    Date.new(*date_components)
  end
end

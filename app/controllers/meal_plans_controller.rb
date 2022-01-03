# frozen_string_literal: true

class MealPlansController < ApplicationController
  before_action :set_meal_plan, only: %i[show edit update destroy]
  before_action :available_meals, only: %i[create edit]

  # GET /meal_plans or /meal_plans.json
  def index
    @meal_plans = MealPlan.all
    @current_meal_plan = MealPlan.current.first
  end

  # GET /meal_plans/1 or /meal_plans/1.json
  def show; end

  def new
    @meal_plan = MealPlan.new
  end

  def edit; end

  def create
    @meal_plan = MealPlan.new(start_date: date_param_to_date(meal_plan_params, :start_date),
                              end_date: date_param_to_date(meal_plan_params, :end_date))

    if @meal_plan.save
      MealPlanMeal.create(meal_plan_params.fetch(:meal_ids, []).map do |meal_id|
                            { meal_id: meal_id, meal_plan: @meal_plan }
                          end)

      redirect_to @meal_plan, notice: 'Meal plan was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @meal_plan.update(meal_plan_params)
      redirect_to @meal_plan, notice: 'Meal plan was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @meal_plan.destroy
    respond_to do |format|
      format.html { redirect_to meal_plans_url, notice: 'Meal plan was successfully destroyed.' }
      format.json { head :no_content }
    end
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

  def date_param_to_date(params_hash, param_name)
    date_components = %w[1 2 3].map { |e| params_hash["#{param_name}(#{e}i)"].to_i }
    Date.new(*date_components)
  end
end

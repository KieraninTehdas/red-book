class MealPlansController < ApplicationController
  before_action :set_meal_plan, only: %i[ show edit update destroy ]
  before_action :available_meals, only: %i[ create edit ]

  # GET /meal_plans or /meal_plans.json
  def index
    @meal_plans = MealPlan.all
  end

  # GET /meal_plans/1 or /meal_plans/1.json
  def show
  end

  # GET /meal_plans/new
  def new
    @meal_plan = MealPlan.new
  end

  # GET /meal_plans/1/edit
  def edit
  end

  # POST /meal_plans or /meal_plans.json
  def create
    @meal_plan = MealPlan.new(start_date: meal_plan_params[:start_date], end_date: meal_plan_params[:end_date])

    Rails.logger.info(meal_plan_params)

    respond_to do |format|
      if @meal_plan.save

        meal_plan_params[:meal_ids].each do |meal_id|
        meal_plan_meal = MealPlanMeal.new({ meal_id: meal_id, meal_plan: @meal_plan })
        meal_plan_meal.save
        end

        format.html { redirect_to @meal_plan, notice: "Meal plan was successfully created." }
        format.json { render :show, status: :created, location: @meal_plan }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meal_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meal_plans/1 or /meal_plans/1.json
  def update
    respond_to do |format|
      if @meal_plan.update(meal_plan_params)
        format.html { redirect_to @meal_plan, notice: "Meal plan was successfully updated." }
        format.json { render :show, status: :ok, location: @meal_plan }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meal_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meal_plans/1 or /meal_plans/1.json
  def destroy
    @meal_plan.destroy
    respond_to do |format|
      format.html { redirect_to meal_plans_url, notice: "Meal plan was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal_plan
      @meal_plan = MealPlan.find(params[:id])
    end

    def available_meals
      @available_meals = Meal.all
    end

    # Only allow a list of trusted parameters through.
    def meal_plan_params
      params.require(:meal_plan).permit(:start_date, :end_date, :meal_ids => [])
    end
end

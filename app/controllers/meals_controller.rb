class MealsController < ApplicationController
  before_action :set_meal, only: %i[ show edit update destroy ]

  # GET /meals or /meals.json
  def index
    @meals = Meal.all
  end

  # GET /meals/1 or /meals/1.json
  def show
  end

  # GET /meals/new
  def new
    @meal = Meal.new
  end

  # GET /meals/1/edit
  def edit
  end

  # POST /meals or /meals.json
  def create
    
    @meal_params = params[:meal]

    if @meal_params[:recipe_book_name]
      @recipe_book = RecipeBook.find_by_name(@meal_params[:recipe_book_name])

      if !@recipe_book.present?
        @recipe_book = RecipeBook.new(@meal_params[:recipe_book_name])
        @recipe_book.save
      end
    end

    @meal = Meal.new({:name => @meal_params[:name], :recipe_book => @recipe_book})

    respond_to do |format|
      if @meal.save
        format.html { redirect_to action: "index", notice: "Meal was successfully created." }
        format.json { render :show, status: :created, location: @meal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meals/1 or /meals/1.json
  def update
    respond_to do |format|
      if @meal.update(meal_params)
        format.html { redirect_to @meal, notice: "Meal was successfully updated." }
        format.json { render :show, status: :ok, location: @meal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meals/1 or /meals/1.json
  def destroy
    @meal.destroy
    respond_to do |format|
      format.html { redirect_to meals_url, notice: "Meal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meal_params
      params.require(:meal).permit(:name)
    end
end

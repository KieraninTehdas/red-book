# frozen_string_literal: true

class MealsController < ApplicationController
  before_action :set_meal, only: %i[show edit update destroy]

  # GET /meals or /meals.json
  def index
    @meals = Meal.all
  end

  # GET /meals/1 or /meals/1.json
  def show; end

  # GET /meals/new
  def new
    @meal = Meal.new
  end

  # GET /meals/1/edit
  def edit; end

  # POST /meals or /meals.json
  def create
    @recipe_book = find_or_create_recipe_book(meal_params[:recipe_book_name]) if meal_params[:recipe_book_name].present?

    @meal = Meal.new({ name: meal_params[:name], recipe_book: @recipe_book,
                       page_number: meal_params[:page_number] })

    respond_to do |format|
      if @meal.save
        format.html { redirect_to action: 'index', notice: 'Meal was successfully created.' }
        format.json { render :show, status: :created, location: @meal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meals/1 or /meals/1.json
  def update
    @recipe_book = @meal.recipe_book
    if meal_params[:recipe_book_name].present? && meal_params[:recipe_book_name] != @meal.recipe_book_name
      @recipe_book = find_or_create_recipe_book(meal_params[:recipe_book_name])
    end

    Rails.logger.error(@recipe_book.as_json)

    respond_to do |format|
      if @meal.update({ name: meal_params[:name], recipe_book: @recipe_book,
                        page_number: meal_params[:page_number] })
        format.html { redirect_to @meal, notice: 'Meal was successfully updated.' }
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
      format.html { redirect_to meals_url, notice: 'Meal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def find_or_create_recipe_book(_recipe_book_name)
    @recipe_book = RecipeBook.find_by(name: meal_params[:recipe_book_name])

    if @recipe_book.blank?
      @recipe_book = RecipeBook.new({ name: meal_params[:recipe_book_name] })
      @recipe_book.save
    end

    @recipe_book
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_meal
    @meal = Meal.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def meal_params
    params.require(:meal)
  end
end

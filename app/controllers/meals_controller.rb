# frozen_string_literal: true

class MealsController < ApplicationController
  before_action :set_meal, only: %i[show edit update destroy]

  def index
    @meals = Meal.all
  end

  def show; end

  def new
    @meal = Meal.new
  end

  def edit; end

  def create
    @recipe_book = find_or_create_recipe_book(meal_params[:recipe_book_name]) if meal_params[:recipe_book_name].present?

    @meal = Meal.new({ name: meal_params[:name], recipe_book: @recipe_book,
                       page_number: meal_params[:page_number] })

    if @meal.save
      redirect_to action: 'index', notice: 'Meal was successfully created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @recipe_book = @meal.recipe_book

    # TODO: searching by names seems iffy...
    @recipe_book = find_or_create_recipe_book(meal_params[:recipe_book_name]) if recipe_book_changed?

    if @meal.update({ name: meal_params[:name], recipe_book: @recipe_book,
                      page_number: meal_params[:page_number] })
      redirect_to @meal, notice: 'Meal was successfully updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @meal.destroy
    redirect_to meals_url, notice: 'Meal was successfully destroyed.'
  end

  private

  def find_or_create_recipe_book(_recipe_book_name)
    @recipe_book = RecipeBook.find_by(name: meal_params[:recipe_book_name])

    if @recipe_book.blank?
      @recipe_book = RecipeBook.new({ name: meal_params[:recipe_book_name] })
      @recipe_book.save!
    end

    @recipe_book
  end

  def recipe_book_changed?
    meal_params[:recipe_book_name].present? && meal_params[:recipe_book_name] != @meal.recipe_book_name
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

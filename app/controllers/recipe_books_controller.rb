# frozen_string_literal: true

class RecipeBooksController < ApplicationController
  before_action :set_recipe_book, only: %i[show edit update destroy]

  def index
    @recipe_books = RecipeBook.all
  end

  def show; end

  def new
    @recipe_book = RecipeBook.new
  end

  def edit; end

  def create
    @recipe_book = RecipeBook.new(recipe_book_params)

    if @recipe_book.save
      redirect_to @recipe_book, notice: 'Recipe book was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @recipe_book.update(recipe_book_params)
      redirect_to @recipe_book, notice: 'Recipe book was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe_book.destroy
    redirect_to recipe_books_url, notice: 'Recipe book was successfully destroyed.'
  end

  private

  def set_recipe_book
    @recipe_book = RecipeBook.find(params[:id])
  end

  def recipe_book_params
    params.require(:recipe_book).permit(:name)
  end
end

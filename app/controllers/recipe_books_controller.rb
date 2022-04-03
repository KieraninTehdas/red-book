# frozen_string_literal: true

class RecipeBooksController < ApplicationController
  before_action :set_recipe_book, only: %i[show edit update destroy]

  # GET /recipe_books or /recipe_books.json
  def index
    @recipe_books = RecipeBook.all
  end

  # GET /recipe_books/1 or /recipe_books/1.json
  def show; end

  def search
    book_name = RecipeBook.arel_table[:name]
    query_string = params[:name]

    return render json: [] if query_string.blank?

    sanitized_query_string = query_string.gsub(/[%_,]/, { '%': '', _: '', ',': '\\,' })

    render json: RecipeBook.where(book_name.matches("%#{sanitized_query_string}%"))
  end

  # GET /recipe_books/new
  def new
    @recipe_book = RecipeBook.new
  end

  # GET /recipe_books/1/edit
  def edit; end

  # POST /recipe_books or /recipe_books.json
  def create
    @recipe_book = RecipeBook.new(recipe_book_params)

    respond_to do |format|
      if @recipe_book.save
        format.html { redirect_to @recipe_book, notice: 'Recipe book was successfully created.' }
        format.json { render :show, status: :created, location: @recipe_book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe_book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipe_books/1 or /recipe_books/1.json
  def update
    respond_to do |format|
      if @recipe_book.update(recipe_book_params)
        format.html { redirect_to @recipe_book, notice: 'Recipe book was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe_book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe_book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipe_books/1 or /recipe_books/1.json
  def destroy
    @recipe_book.disassociate_meals
    @recipe_book.destroy
    respond_to do |format|
      format.html { redirect_to recipe_books_url, notice: 'Recipe book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe_book
    @recipe_book = RecipeBook.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_book_params
    params.require(:recipe_book).permit(:name)
  end
end

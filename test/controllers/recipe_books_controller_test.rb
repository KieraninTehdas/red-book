require "test_helper"

class RecipeBooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recipe_book = recipe_books(:one)
  end

  test "should get index" do
    get recipe_books_url
    assert_response :success
  end

  test "should get new" do
    get new_recipe_book_url
    assert_response :success
  end

  test "should create recipe_book" do
    assert_difference('RecipeBook.count') do
      post recipe_books_url, params: { recipe_book: { name: @recipe_book.name } }
    end

    assert_redirected_to recipe_book_url(RecipeBook.last)
  end

  test "should show recipe_book" do
    get recipe_book_url(@recipe_book)
    assert_response :success
  end

  test "should get edit" do
    get edit_recipe_book_url(@recipe_book)
    assert_response :success
  end

  test "should update recipe_book" do
    patch recipe_book_url(@recipe_book), params: { recipe_book: { name: @recipe_book.name } }
    assert_redirected_to recipe_book_url(@recipe_book)
  end

  test "should destroy recipe_book" do
    assert_difference('RecipeBook.count', -1) do
      delete recipe_book_url(@recipe_book)
    end

    assert_redirected_to recipe_books_url
  end
end

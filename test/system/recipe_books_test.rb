require "application_system_test_case"

class RecipeBooksTest < ApplicationSystemTestCase
  setup do
    @recipe_book = recipe_books(:one)
  end

  test "visiting the index" do
    visit recipe_books_url
    assert_selector "h1", text: "Recipe Books"
  end

  test "creating a Recipe book" do
    visit recipe_books_url
    click_on "New Recipe Book"

    fill_in "Name", with: @recipe_book.name
    click_on "Create Recipe book"

    assert_text "Recipe book was successfully created"
    click_on "Back"
  end

  test "updating a Recipe book" do
    visit recipe_books_url
    click_on "Edit", match: :first

    fill_in "Name", with: @recipe_book.name
    click_on "Update Recipe book"

    assert_text "Recipe book was successfully updated"
    click_on "Back"
  end

  test "destroying a Recipe book" do
    visit recipe_books_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Recipe book was successfully destroyed"
  end
end

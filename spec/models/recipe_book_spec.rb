# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeBook, type: :model do
  context 'when name is missing' do
    it 'does not save' do
      expect(described_class.new.save).to be false
    end
  end

  describe 'before_destroy' do
    it 'removes associated meal pages' do
      recipe_book = create(:recipe_book)
      meal = Meal.new(name: 'Food', recipe_book: recipe_book, page_number: 12)
      meal.save!
      recipe_book.reload

      recipe_book.destroy

      expect { recipe_book.reload }.to raise_error(ActiveRecord::RecordNotFound)
      meal.reload
      expect(meal.recipe_book).to be_nil
      expect(meal.page_number).to be_nil
    end
  end
end

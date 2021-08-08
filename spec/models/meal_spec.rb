require 'rails_helper'

RSpec.describe Meal, type: :model do
  context 'when meal only has a name' do
    it 'is saved successfully' do
      expect(Meal.new({name: 'Name'}).save).to be true
    end
  end

  context 'when page number is set without recipe book' do
    it 'is not saved successfully' do
      expect(Meal.new({name: 'Name', page_number: 55}).save).to be false
    end
  end

  context 'when recipe book and page number are both set' do
    let(:recipe_book) { create(:recipe_book) }

    it 'is saved successfully' do
      expect(Meal.new({name: 'Name', recipe_book: recipe_book, page_number: 55}).save).to be true
    end
  end

  context 'when recipe book is set' do
    let(:recipe_book) { create(:recipe_book) }

    context 'and page number is non-numeric' do
      it 'is not saved successfully' do
        expect(Meal.new({name: 'Name', recipe_book: recipe_book, page_number: 'wc3f'}).save).to be false
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Meal, type: :model do
  context 'when meal only has a name' do
    it 'is saved successfully' do
      expect(Meal.new({ name: 'Name' }).save).to be true
    end
  end

  context 'when name is missing' do
    it 'is not saved successfully' do
      expect(Meal.new.save).to be false
    end
  end

  context 'when name is empty' do
    it 'is not saved successfully' do
      expect(Meal.new({ name: '' }).save).to be false
    end
  end

  context 'recipe book is not set' do
    context 'and page number is set' do
      it 'is not saved successfully' do
        expect(Meal.new({ name: 'Name', page_number: 55 }).save).to be false
      end
    end

    it 'returns nil when recipe_book_name is called' do
      expect(Meal.new({ name: 'Name' }).recipe_book_name).to be_nil
    end
  end

  context 'when recipe book and page number are both set' do
    let(:recipe_book) { create(:recipe_book) }

    it 'is saved successfully' do
      expect(Meal.new({ name: 'Name', recipe_book: recipe_book, page_number: 55 }).save).to be true
    end
  end

  context 'when recipe book is set' do
    let(:recipe_book) { create(:recipe_book) }

    context 'and page number is not set' do
      it 'is saved successfully' do
        expect(Meal.new({ name: 'Name', recipe_book: recipe_book }).save).to be true
      end
    end

    context 'and page number is non-numeric' do
      it 'is not saved successfully' do
        expect(Meal.new({ name: 'Name', recipe_book: recipe_book, page_number: 'wc3f' }).save).to be false
      end
    end

    context 'and page number is not an integer' do
      it 'is not saved successfully' do
        expect(Meal.new({ name: 'Name', recipe_book: recipe_book, page_number: '15.353' }).save).to be false
      end
    end

    it 'recipe_book_name returns the correct name' do
      meal = Meal.new({ name: 'Name', recipe_book: recipe_book })

      expect(meal.recipe_book_name).to eq recipe_book.name
    end
  end
end

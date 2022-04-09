# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Meals', type: :request do
  describe '#create' do
    context 'when no recipe book is specified' do
      let(:params) { { meal: { name: 'Food' } } }

      it 'saves a new meal' do
        expect { post meals_path, params: params }.to change(Meal, :count).by(1)
      end
        .id
      it 'redirects to meals index' do
        post meals_url, params: params

        expect(response).to redirect_to action: 'index', notice: 'Meal was successfully created'
      end

      context 'when page number is specified' do
        before do
          params[:meal][:page_number] = 10
        end

        it "doesn't save a new meal" do
          expect { post meals_url, params: params }.not_to change(Meal, :count)
        end

        it 'returns 422' do
          post meals_url, params: params

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when receipe book is specified' do
      let(:recipe_book) { create(:recipe_book) }
      let(:params) { { meal: { name: 'Food', recipe_book_id: recipe_book.id } } }

      it 'saves a new meal' do
        expect { post meals_url, params: params }.to change(Meal, :count).by(1)
        expect(Meal.last.recipe_book).to eq(recipe_book)
      end

      context 'when page number is specified' do
        it 'sets the correct page number' do
          params[:meal][:page_number] = 10

          post meals_url, params: params

          expect(Meal.last.page_number).to eq(10)
        end
      end
    end

    context 'when ingredients are specified' do
      it 'saves them' do
        ingredients = 'here\n is a\n list of, stuff'
        params = { meal: { name: 'Food', ingredients: ingredients } }

        post meals_url, params: params

        expect(Meal.last.ingredients).to eq(ingredients)
      end
    end
  end

  describe '#update' do
    let(:recipe_book) { create(:recipe_book) }

    context 'when adding a book and page number' do
      it 'updates the specified fields' do
        meal = create(:meal)
        params = { meal: { name: meal.name, recipe_book_id: recipe_book.id, page_number: 12 } }

        put meal_path(meal), params: params

        meal.reload
        expect(meal.recipe_book).to eq(recipe_book)
        expect(meal.page_number).to eq(12)
      end
    end

    context 'when removing book and page number' do
      it 'updates the specified fields' do
        meal = create(:meal, :with_recipe_book)
        params = { meal: { name: meal.name, recipe_book_id: nil, page_number: '' } }

        put meal_path(meal), params: params

        meal.reload
        expect(meal.recipe_book).to be_nil
        expect(meal.page_number).to be_nil
      end
    end

    context 'when removing recipe book but not page number' do
      it 'does not update' do
        meal = create(:meal, :with_recipe_book)
        initial_recipe_book = meal.recipe_book
        params = { meal: { name: meal.name, recipe_book_id: '', page_number: '12' } }

        put meal_path(meal), params: params

        meal.reload
        expect(meal.recipe_book).to eq(initial_recipe_book)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

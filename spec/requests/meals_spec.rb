# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Meals', type: :request do
  describe '#create' do
    context 'when no recipe book is specified' do
      let(:params) { { meal: { name: 'Food' } } }

      it 'saves a new meal' do
        expect { post meals_url, params: params }.to change(Meal, :count).by(1)
      end

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

    context 'when new receipe book is specified' do
      let(:params) { { meal: { name: 'Food', recipe_book_name: 'New Book' } } }

      it 'saves a new meal' do
        expect { post meals_url, params: params }.to change(Meal, :count).by(1)
        expect(Meal.last.recipe_book.name).to eq('New Book')
      end

      it 'saves a new book' do
        expect { post meals_url, params: params }.to change(RecipeBook, :count).by(1)
      end

      context 'when page number is specified' do
        it 'sets the correct page number' do
          params[:meal][:page_number] = 10

          post meals_url, params: params

          expect(Meal.last.page_number).to eq(10)
        end
      end
    end

    context 'when existing recipe book is specified' do
      let!(:recipe_book) { create(:recipe_book) }
      let(:params) { { meal: { name: 'Food', recipe_book_name: recipe_book.name } } }

      it 'saves a new meal' do
        expect { post meals_url, params: params }.to change(Meal, :count).by(1)
        expect(Meal.last.recipe_book).to eq(recipe_book)
      end

      it "doesn't save a new book" do
        expect { post meals_url, params: params }.not_to change(RecipeBook, :count)
      end
    end
  end

  describe 'update' do
    let!(:meal) { create(:meal) }
    let(:update_url) { "#{meals_url}/#{meal.id}" }

    context 'when updating recipe book' do
      context 'when book exists' do
        let(:recipe_book) { create(:recipe_book) }

        it 'updates the recipe book' do
          params = { meal: { name: meal.name, recipe_book_name: recipe_book.name } }
          initial_recipe_book_count = RecipeBook.count

          put update_url, params: params

          meal.reload
          expect(meal.recipe_book).to eq(recipe_book)
          expect(RecipeBook.count).to eq(initial_recipe_book_count)
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MealsController do
  let!(:meals) { create_list(:meal, 6) }

  describe 'GET index' do
    it 'assigns @meals' do
      get :index

      expect(assigns(:meals)).to eq([meals])
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MealPlan, type: :model do
  let(:today) { Time.zone.today }

  describe 'validations' do
    context 'when start date is before end date' do
      it 'saves successfully' do
        expect(described_class.new({ start_date: today - 1, end_date: today }).save).to be true
      end
    end

    context 'when end date is before start date' do
      it 'does not save successfully' do
        expect(described_class.new({ start_date: today, end_date: today - 1 }).save).to be false
      end
    end
  end

  describe '#complete?' do
    let(:meal_plan) { build(:meal_plan) }

    it 'returns true when all meals are eaten' do
      meal_plan.meal_plan_meals.build(meal: build(:meal), eaten: true)

      expect(meal_plan.complete?).to be true
    end

    it 'returns false when not all meals are eaten' do
      meal_plan.meal_plan_meals.build(meal: build(:meal), eaten: true)
      meal_plan.meal_plan_meals.build(meal: build(:meal), eaten: false)

      expect(meal_plan.complete?).to be false
    end
  end

  context 'when there are multiple plans' do
    let!(:past_plan) { create(:meal_plan, start_date: today - 10, end_date: today - 5) }
    let!(:future_plan) { create(:meal_plan, start_date: today + 3, end_date: today + 10) }
    let!(:plan_ending_today) { create(:meal_plan, start_date: today - 5, end_date: today) }
    let!(:plan_starting_today) { create(:meal_plan, start_date: today, end_date: today + 7) }

    describe 'past scope' do
      it 'returns meal plans with end date before today' do
        result = described_class.past

        expect(result.count).to eq(1)
        expect(result).to contain_exactly(past_plan)
      end
    end

    describe 'current scope' do
      it 'returns plans that are in progress' do
        result = described_class.current

        expect(result.count).to eq(2)
        expect(result).to contain_exactly(plan_starting_today, plan_ending_today)
      end
    end

    describe 'future scope' do
      it 'returns meal plans with start date after today' do
        result = described_class.future

        expect(result.count).to eq(1)
        expect(result).to contain_exactly(future_plan)
      end
    end
  end
end

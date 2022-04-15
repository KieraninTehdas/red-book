# frozen_string_literal: true

class MealPlan < ApplicationRecord
  has_many :meal_plan_meals, dependent: :delete_all
  has_many :meals, through: :meal_plan_meals

  validates :start_date, :end_date, presence: true
  validate :end_after_start?

  scope :past, -> { where('end_date < ?', Time.zone.today) }
  scope :future, -> { where('start_date > ?', Time.zone.today) }
  scope :current, -> { where('start_date <= ? and end_date >= ?', Time.zone.today, Time.zone.today) }

  def complete?
    meal_plan_meals.map { |plan_meal| plan_meal.eaten? }.all?
  end

  private

  def end_after_start?
    errors.add(:end_date, 'must be after start date') if end_date < start_date
  end
end

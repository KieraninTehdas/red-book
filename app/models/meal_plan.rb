# frozen_string_literal: true

class MealPlan < ApplicationRecord
  has_many :meal_plan_meals
  has_many :meals, through: :meal_plan_meals

  validates :start_date, :end_date, presence: true
  validate :end_after_start?

  scope :past, -> { where('end_date < ?', Date.today) }
  scope :future, -> { where('start_date > ?', Date.today) }
  scope :current, -> { where('start_date <= ? and end_date >= ?', Date.today, Date.today) }

  private

  def end_after_start?
    errors.add(:end_date, 'must be after start date') if end_date < start_date
  end
end

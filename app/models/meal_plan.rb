class MealPlan < ApplicationRecord
  has_many :meal_plan_meals
  has_many :meals, through: :meal_plan_meals

  validates :start_date, :end_date, presence: true
  validate :end_after_start?

  scope :past, -> { where('end_date < ?', Date.today) }
  scope :future, -> { where('start_date > ?', Date.today) }

  def end_after_start?
    errors.add(:end_date, 'must be after start date') if end_date < start_date
  end
end

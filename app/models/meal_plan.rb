class MealPlan < ApplicationRecord
  has_many :meal_plan_meals
  has_many :meals, through: :meal_plan_meals

  validate :end_after_start?

  scope :past, -> { where("end_date < ?", Date.today) }
  scope :future, -> { where("start_date > ?", Date.today) }

  def end_after_start?
    if end_date < start_date
      errors.add(:end_date, "must be after start date")
    end
  end
end

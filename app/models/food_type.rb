class FoodType < ActiveRecord::Base
  has_many :agencies, through: :accepted_foods
  has_many :accepted_foods

  def self.alphabetize
    order(name: :asc)
  end
end

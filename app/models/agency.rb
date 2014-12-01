class Agency < ActiveRecord::Base
  has_many :food_types, through: :accepted_foods
  has_many :accepted_foods

  def self.alphabetize
    order(name: :asc)
  end
end

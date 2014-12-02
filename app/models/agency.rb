class Agency < ActiveRecord::Base
  has_many :accepted_foods
  has_many :food_types, through: :accepted_foods

  validates :address, presence: true
  validates :city, presence: true
  validates :name, presence: true, uniqueness: true
  validates :phone, presence: true
  validates :zipcode, presence: true

  def self.alphabetize
    order(name: :asc)
  end
end

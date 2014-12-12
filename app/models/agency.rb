class Agency < ActiveRecord::Base
  SEARCH = "name ILIKE :query OR zipcode ILIKE :query"

  geocoded_by :full_address
  after_validation :geocode

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

  def self.search(query)
    where(SEARCH, query: "%#{query}%")
  end

  def full_address
    "#{address}, #{city}, NY #{zipcode}"
  end
end

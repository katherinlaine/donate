class Agency < ActiveRecord::Base
  SEARCH = "name ILIKE :query OR zipcode ILIKE :query"

  geocoded_by :full_address
  after_validation :geocode, if: :full_address_changed?

  has_many :accepted_foods
  has_many :food_types, through: :accepted_foods

  validates :address, presence: true
  validates :city, presence: true
  validates :name, presence: true, uniqueness: true
  validates :phone, presence: true
  validates :zipcode, presence: true
  validates_format_of :zipcode,
                      with: /\A\d{5}(-\d{4})?\z/,
                      message: ": Incorrect format"

  paginates_per 7

  def full_address_changed?
    address_changed? || city_changed? || zipcode.changed?
  end

  def self.alphabetize
    order(name: :asc)
  end

  def self.search(query)
    where(SEARCH, query: "%#{query}%")
  end

  def full_address
    "#{address}, #{city}, NY #{zipcode}"
  end

  def self.import(file, ids)
    importer = CSVImporter.new
    importer.run_import(file, ids)
  end
end

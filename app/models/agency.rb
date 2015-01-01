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

  def self.import(file)
    ids = ["1", "2", "3", "5"]
    CSV.foreach(file.path, headers: true, encoding: "ISO-8859-1") do |row|
      row_data = row.to_hash
      accepted_food_types = row_data.select { |key, value| (ids.include? key) && (value == "1") }
      agency_data = {
        name: row_data["Account Name"],
        contact: row_data["Primary Contact"],
        phone: row_data["Main Phone"],
        address: row_data["Delivery Address Street 1"],
        city: row_data["Borough"],
        zipcode: row_data["Delivery Address: ZIP Code"],
        food_type_ids: accepted_food_types.keys
      }
      agency = Agency.new(agency_data)
      agency.save
    end
  end
end

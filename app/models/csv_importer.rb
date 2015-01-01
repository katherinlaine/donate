class CSVImporter
  def initialize(file, ids)
    @file = file
    @ids = ids
  end

  def run_import
    CSV.foreach(@file.path, headers: true, encoding: "ISO-8859-1") do |row|
      row_data = row.to_hash

      accepted_fa_ids = collect_usable_fa_food_types(row_data, @ids).keys
      accepted_food_types = look_up_types_by_fa_ids(accepted_fa_ids)
      food_type_ids = map_to_ids(accepted_food_types)
      collect_agency_data(row_data, food_type_ids)

      Agency.create!(@agency_data)
    end
  end

  private

  def collect_usable_fa_food_types(row_data, ids)
    row_data.select do
      |key, value| (ids.include? key) && (value == "1")
    end
  end

  def look_up_types_by_fa_ids(accepted_fa_ids)
    accepted_fa_ids.map do
      |fa_id| FoodType.find_by(feeding_america_id: fa_id)
    end
  end

  def map_to_ids(accepted_food_types)
    accepted_food_types.map do
      |food_type| food_type.id.to_s
    end
  end

  def collect_agency_data(row_data, food_type_ids)
    @agency_data = {
      name: row_data["Account Name"],
      contact: row_data["Primary Contact"],
      phone: row_data["Main Phone"],
      address: row_data["Delivery Address Street 1"],
      city: row_data["Borough"],
      zipcode: row_data["Delivery Address: ZIP Code"],
      food_type_ids: food_type_ids
    }
  end
end

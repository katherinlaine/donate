class CSVImporter
  def run_import(file, ids)
    @ids = ids
    CSV.foreach(file.path, headers: true, encoding: "ISO-8859-1") do |row|
      @row_data = row.to_hash

      Agency.create! agency_data
    end
  end

  private

  def agency_data
    {
      name: @row_data["Account Name"].strip,
      contact: @row_data["Primary Contact"].strip,
      phone: clean_phone_number(@row_data["Main Phone"]),
      address: @row_data["Delivery Address Street 1"],
      city: @row_data["Borough"].strip,
      zipcode: @row_data["Delivery Address: ZIP Code"].strip,
      food_type_ids: food_type_ids
    }
  end

  def clean_phone_number(number)
    clean_number = number.strip.gsub(/[^\d]+/, "")
    "(#{clean_number[0..2]}) #{clean_number[3..5]}-#{clean_number[6..9]}"
  end

  def food_type_ids
    look_up_food_types.map do |food_type|
      food_type.id.to_s
    end
  end

  def look_up_food_types
    collect_accepted_fa_ids(@row_data, @ids).map do |fa_id|
      FoodType.find_by(feeding_america_id: fa_id)
    end
  end

  def collect_accepted_fa_ids(row_data, ids)
    row_data.select do |key, value|
      (ids.include? key) && (value == "1")
    end.keys
  end
end

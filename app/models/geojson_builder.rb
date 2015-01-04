class GeojsonBuilder
  def initialize(locations)
    @locations = locations
  end

  def to_geojson
    @locations.map do |agency|
      agency_to_geojson(agency)
    end.to_json
  end

  def to_your_geojson_location
    your_location_to_geojson(@locations).to_json
  end

  private

  def agency_to_geojson(agency)
    {
      type: "Feature",
      geometry: {
        type: "Point",
        coordinates: [agency.longitude, agency.latitude]
      },
      properties: {
        title: agency.name,
        "marker-size" => "small",
        "marker-color" => "000000",
        "marker-symbol" => "circle"
      }
    }
  end

  def your_location_to_geojson(location)
    {
      type: "Feature",
      geometry: {
        type: "Point",
        coordinates: [location.longitude, location.latitude]
      },
      properties: {
        title: "Your Location",
        "marker-size" => "small",
        "marker-color" => "FFFFFF",
        "marker-symbol" => "circle"
      }
    }
  end
end

class GeojsonBuilder
  def initialize(agencies)
    @agencies = agencies
  end

  def to_geojson
    @agencies.map do |agency|
      agency_to_json(agency)
    end.to_json
  end

  private

  def agency_to_json(agency)
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
end

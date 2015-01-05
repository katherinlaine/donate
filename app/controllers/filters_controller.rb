class FiltersController < ApplicationController
  def show
    @agencies = Agency.all

    check_for_food_type_query
    check_for_location_query
    add_markers_and_narrow_search_by_location

    @agencies = @agencies.page params[:page]
    @agency_markers = GeojsonBuilder.new(@agencies).to_geojson
  end

  private

  def food_type_params
    params.permit(:food_types)
  end

  def check_for_food_type_query
    if food_type_params[:food_types].present?
      narrow_by_accepted_food_types
    end
  end

  def narrow_by_accepted_food_types
    @agencies = @agencies.
      joins(:food_types).
      where(food_types: { id: food_type_params[:food_types] })
  end

  def check_for_location_query
    if !filter_params[:city_search].empty?
      @location = Geocoder.search(filter_params[:city_search]).first
    elsif filter_params[:current_location] == "Yes"
      @location = request.location
    end
  end

  def add_markers_and_narrow_search_by_location
    unless @location.nil?
      @location_marker = GeojsonBuilder.new(@location).to_your_geojson_location
      @agencies = @agencies.near(@location.coordinates, 1)
    end
  end

  def filter_params
    params.permit(:current_location, :city_search)
  end
end

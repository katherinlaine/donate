class FiltersController < ApplicationController
  def show
    @agencies = Agency.where(add_filters(filter_params))

    if food_type_params[:food_types].present?
      @agencies = @agencies.
        joins(:food_types)
        where(food_types: { id: food_type_params[:food_types] })
    end

    if !filter_params[:current_location].empty?
      location = request.location
      binding.pry
      @agencies = @agencies.near(location.latitude, location.longitude)
    end

    @agency_markers = GeojsonBuilder.new(@agencies).to_geojson

    render "searches/show"
  end

  private

  def food_type_params
    params.permit(:food_types)
  end

  def filter_params
    params.permit(:city, :current_location)
  end

  def add_filters(search_params)
    search_params.select { |_, value| value.present? }
  end
end

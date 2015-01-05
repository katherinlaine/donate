class AgencyFilter
  attr_reader :params, :agencies

  def initialize(agencies, params)
    @agencies = agencies
    @params = params
  end

  def filter_agencies_by_food_type
    check_for_food_type_query
  end

  def get_location_query
    if !location_params[:city_search].empty?
      (location_params[:city_search])
    elsif location_params[:current_location] == "Yes"
      request.location
    end
  end

  private

  def food_type_params
    params.permit(:food_types)
  end

  def location_params
    params.permit(:city_search, :current_location)
  end

  def check_for_food_type_query
    if food_type_params[:food_types].present?
      narrow_by_food_types
    end
  end

  def narrow_by_food_types
    agencies.
      joins(:food_types).
      where(food_types: { id: food_type_params[:food_types] })
  end

  def narrow_search_by_location
    unless @location.nil?
      agencies.near(@location.coordinates, 1)
    end
  end
end

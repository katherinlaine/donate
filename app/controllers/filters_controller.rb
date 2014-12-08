class FiltersController < ApplicationController
  def show
    @agencies = Agency.where(add_filters(filter_params))
    if food_type_params[:food_types].present?
      @agencies = @agencies.
        joins(:food_types).
        where(food_types: { id: food_type_params[:food_types] })
    end

    render "searches/show"
  end

  private

  def food_type_params
    params.permit(:food_types)
  end

  def filter_params
    params.permit(:city)
  end

  def add_filters(search_params)
    search_params.select { |_, value| value.present? }
  end
end

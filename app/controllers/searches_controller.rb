class SearchesController < ApplicationController
  def show
    @agencies = Agency.search(params[:query])
    @agency_markers = GeojsonBuilder.new(@agencies).to_geojson
  end
end

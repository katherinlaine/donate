class AgenciesController < ApplicationController
  def show
    @agency = Agency.find(params[:id])
    @agency_markers = GeojsonBuilder.new([@agency]).to_geojson
  end

  def index
    @agencies = Agency.all
    @agency_markers = GeojsonBuilder.new(@agencies).to_geojson
  end
end

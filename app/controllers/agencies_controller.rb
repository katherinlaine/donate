class AgenciesController < ApplicationController
  def show
    @agency = Agency.find(params[:id])
  end

  def index
    @agencies = Agency.all
  end
end

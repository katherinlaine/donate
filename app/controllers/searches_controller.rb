class SearchesController < ApplicationController
  def show
    @agencies = Agency.search(params[:query])
  end
end

class Api::AutocompleteController < ApplicationController
  def cities
    @cities = Listing::ALL_CITIES
    render json: @cities.map
    # @cities = Listing::ALL_CITIES.find_all { |city| city.match("#{params[:term]}") }
    # render json: @cities.map
  end

  def tracts
  end

  def communities
  end
end

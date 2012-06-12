class Api::AutocompleteController < ApplicationController
  def cities
    @cities = Listing::ALL_CITIES
    render json: @cities.map

    # @cities = City.order(:name).where("name like ?", "%#{params[:term]}%")
    # render json: @cities.map(&:name)
  end

  def tracts
    @tracts = Tract.order(:name).where("name like ?", "%#{params[:term]}%")
    render json: @tracts.map(&:name)
  end

  def communities
  end

  def combined
  end
end

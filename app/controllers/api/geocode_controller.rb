class Api::GeocodeController < ApplicationController
  include Api::Shared::ErrorsHelper
  include Api::GeocodeHelper 

  before_filter :validate_params

  ACCEPTABLE_PARAMS = ["ne_long", "sw_long", "ne_lat", "sw_lat", "controller", "action", "format"]

  def index
    ### boundary method
    # populate geocode variables
    ne_long = params[:ne_long]
    sw_long = params[:sw_long]
    ne_lat = params[:ne_lat]
    sw_lat = params[:sw_lat]

    # find records between the given parameters 
    if ne_long > sw_long
      @listings = Listing.find_by_sql("SELECT * FROM listings WHERE (\"Longitude\" > #{sw_long} AND \"Longitude\" < #{ne_long}) AND (\"Latitude\" >= #{sw_lat} AND \"Latitude\" <= #{ne_lat}) LIMIT 3;")
    else
      @listings = Listing.find_by_sql("SELECT * FROM listings WHERE (\"Longitude\" >= #{sw_long} AND \"Longitude\" <= #{ne_long}) AND (\"Latitude\" >= #{sw_lat} AND \"Latitude\" <= #{ne_lat}) LIMIT 3;")
    end

    # put LatLng details into the markers hash
    # *may be slower than pushing up the attributes directly...
    @markers = {}
    i = 1
    @listings.each do |l|
      @markers["marker#{i}"] = [l.Latitude, l.Longitude]
      i = i + 1
    end

    if @markers.count == 0
      respond_error("No matches found")
    end

    ### common point method
  end

  def validate_params
    @user_params = {}
    # add params to @user_params hash
    params.each do |key, value|
      if ACCEPTABLE_PARAMS.include?(key)
        if /action/.match(key) || /controller/.match(key) || /format/.match(key) || /Token/.match(key)
          # do nothing
        else
          @user_params["#{key}"] = value
        end
      else
        respond_error("The following parameter is invalid: #{key}")
      end
    end

    # make sure all boundaries are present
    if !@user_params.include?("ne_long" && "sw_long" && "ne_lat" && "sw_lat")
      respond_error("You must include all four geocode parameters.")
    else
      # do nothing
    end
  end

end

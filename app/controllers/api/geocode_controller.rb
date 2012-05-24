class Api::GeocodeController < ApplicationController
  include Api::Shared::ErrorsHelper
  include Api::GeocodeHelper 

  before_filter :validate_params

  ACCEPTABLE_PARAMS = ["Address", "Limit", "ListPrice", "BedroomsTotal", "BathsTotal", "BuildingSizeSQFT", "ne_long", "sw_long", "ne_lat", "sw_lat", "controller", "action", "format", "callback", "_"]

  def index
    ### boundary method
    # populate geocode variables
    ne_long = params[:ne_long]
    sw_long = params[:sw_long]
    ne_lat = params[:ne_lat]
    sw_lat = params[:sw_lat]

    # contruct additional @query params
    @query = "SELECT * FROM listings WHERE "
    @user_params.each do |key, value|
      if /ListPrice/.match(key)
        price_exp = "/\A" + params[:ListPrice] + "/"
        if price_exp.match('>')
          @query = @query + "\"ListPrice\" > '#{value[1..-1]}' AND "
        elsif price_exp.match('<')
          @query = @query + "\"ListPrice\" < '#{value[1..-1]}' AND "
        else
          respond_error("Could not parse ListPrice")
        end
      elsif /BathsTotal/.match(key) || /BedroomsTotal/.match(key) || /LotSizeSQFT/.match(key)
        @query = @query + "\"#{key}\" >= '#{value}' AND "
      elsif /Limit/.match(key)
        @query_limit = " LIMIT #{value}"
      else
        @query = @query + "\"#{key}\" = '#{value}' AND "
      end
    end

    # append boundary parameters, execute search
    if ne_long > sw_long
      @query = @query + "(\"Longitude\" > #{sw_long} AND \"Longitude\" < #{ne_long}) AND (\"Latitude\" >= #{sw_lat} AND \"Latitude\" <= #{ne_lat}) AND \"ListingStatus\" = 'ACTIVE'"
      add_limit
      @listings = Listing.find_by_sql(@query)
    else
      @query = @query + "(\"Longitude\" >= #{sw_long} AND \"Longitude\" <= #{ne_long}) AND (\"Latitude\" >= #{sw_lat} AND \"Latitude\" <= #{ne_lat})" 
      add_limit
      @listings = Listing.find_by_sql(@query)
    end

    # this line creates an infinite-level nested hash
    @markers = Hash.new { |k,v| k[v] = Hash.new(&k.default_proc) }

    i = 1
    @listings.each do |l|
      @markers["marker#{i}"]["LatLng"] = [l.Latitude, l.Longitude]
      @markers["marker#{i}"]["ListPrice"] = l.ListPrice.to_i
      @markers["marker#{i}"]["Address"] = l.FullStreetAddress
      @markers["marker#{i}"]["Bedrooms"] = l.BedroomsTotal
      @markers["marker#{i}"]["Baths"] = l.BathsTotal
      @markers["marker#{i}"]["SQFT"] = l.BuildingSize
      i = i + 1
    end

    if @markers.count == 0
      respond_error("No matches found")
    end

    ### common point method
  end

  def geocode
    gc = Geocoder.search(params[:Address])

    if gc.empty?
      respond_error("No results found")
    else
      if gc.count > 1
        respond_fail("Too many results, please make your search more specific.")
      else
        loc = gc.first.geometry["location"]
        latlng = "#{loc["lat"]}, #{loc["lng"]}"

        respond_success(latlng)
      end
    end
  end

  def validate_params
    @user_params = {}
    # add params to @user_params hash
    params.each do |key, value|
      if ACCEPTABLE_PARAMS.include?(key)
        if /action/.match(key) || 
          /controller/.match(key) || 
          /format/.match(key) || 
          /Token/.match(key) || 
          /ne_lat/.match(key) || 
          /ne_long/.match(key) || 
          /sw_lat/.match(key) || 
          /sw_long/.match(key) ||
          /callback/.match(key) ||
          /_/.match(key)
          # do nothing
        else
          @user_params["#{key}"] = value
        end
      else
        respond_error("The following parameter is invalid: #{key}")
      end
    end

    # make sure all boundaries are present
    case action_name
    when "geocode"
      if !params.include?("Address")
        respond_error("You must include the following field: Address")
      end
    when "index"
      if !params.include?("ne_long" && "sw_long" && "ne_lat" && "sw_lat")
        respond_error("You must include all four geocode parameters.")
      elsif params.include?("Address")
        respond_error("Key: 'Address' is unacceptable for the index action")
      else
        # do nothing
      end
    end
  end
end

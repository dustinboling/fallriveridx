class Api::GeocodeController < ApplicationController
  include Api::Shared::ErrorsHelper
  include Api::Shared::BatsdHelper
  include Api::GeocodeHelper 

  before_filter :validate_params
  before_filter :authenticate_referrer

  ACCEPTABLE_PARAMS = ["Token", "Address", "Limit", "ListPrice", 
    "BedroomsTotal", "BathsTotal", "BuildingSize", "LotSizeSQFT", 
    "ne_long", "sw_long", "ne_lat", "sw_lat", "controller", 
    "action", "format", "callback", "_"]

  def index
    ### boundary method
    # populate geocode variables
    ne_long = params[:ne_long]
    sw_long = params[:sw_long]
    ne_lat = params[:ne_lat]
    sw_lat = params[:sw_lat]

    # contruct additional @query params
    @query = "SELECT * FROM listings WHERE \"ListingStatus\" = 'Active' AND "
    @user_params.each do |key, value|
      if /ListPrice/.match(key)
        price_exp = "/\A" + params[:ListPrice] + "/"
        if price_exp.match('>')
          @query = @query + "\"ListPrice\" > '#{value[1..-1]}' AND "
        elsif price_exp.match('<')
          @query = @query + "\"ListPrice\" < '#{value[1..-1]}' AND "
        else
          batsd_log_error(:type => :params)
          respond_error("Could not parse ListPrice")
        end
      elsif /BathsTotal/.match(key) || /BedroomsTotal/.match(key) || /LotSizeSQFT/.match(key) || /BuildingSize/.match(key)
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
      @markers["marker#{i}"]["City"] = l.City
      @markers["marker#{i}"]["State"] = l.State
      @markers["marker#{i}"]["ZipCode"] = l.ZipCode
      @markers["marker#{i}"]["Bedrooms"] = l.BedroomsTotal
      @markers["marker#{i}"]["Baths"] = l.BathsTotal
      @markers["marker#{i}"]["BuildingSize"] = l.BuildingSize
      @markers["marker#{i}"]["LotSizeSQFT"] = l.LotSizeSQFT
      @markers["marker#{i}"]["ListingStatus"] = l.ListingStatus
      @markers["marker#{i}"]["ListingDate"] = l.ListingDate
      i = i + 1
    end

    if @markers.count == 0
      batsd_log_success
      respond_error("No matches found")
    else
      batsd_log_success
    end
  end

  def geocode
    gc = Geocoder.search(params[:Address])

    if gc.empty?
      batsd_log_success
      respond_error("No results found")
    elsif gc.count > 1
      batsd_log_success
      respond_error("Too many results, please make your search more specific.")
    else
      loc = gc.first.geometry["location"]
      latlng = "#{loc["lat"]}, #{loc["lng"]}"

      batsd_log_success
      respond_success(latlng)
    end
  end

  def authenticate_referrer
    if params[:Token] == "" || nil
      batsd_log_error(:type => :auth)
      respond_error("You have not supplied a token")
    elsif User.find_by_authentication_token(params[:Token])
      @user = User.find_by_authentication_token(params[:Token])
      http_ref = request.env["HTTP_REFERER"]

      if @user.authentication_token == "NULL"
        batsd_log_error(:type => :auth)
        respond_error("Your token is invalid. Please make sure your subscription is still active.")
      elsif @user.site_url != http_ref
        ref_split = http_ref.split('/')
        if ref_split.count > 5
          ref_split = ref_split[0..3]
        end
        http_ref = ref_split.join('/')

        if @user.site_url != http_ref
          batsd_log_error(:type => :referer)
          respond_error("This site (#{request.env["HTTP_REFERER"]}) is not activated. Please activate this site, then try again.")
        end
      elsif @user.site_url == "NULL"
        batsd_log_error(:type => :referer)
        respond_error("You have not activated a site on this token yet.") 
      end
    else
      batsd_log_error(:type => :auth)
      respond_error("Could not find an account with this API key. Please verify and update your API key.")
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
        batsd_log_error(:type => :params)
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
        batsd_log_error(:type => :params)
        respond_error("You must include all four geocode parameters.")
      elsif params.include?("Address")
        batsd_log_error(:type => :params)
        respond_error("Key: 'Address' is unacceptable for the index action")
      else
        # do nothing
      end
    end
  end
end

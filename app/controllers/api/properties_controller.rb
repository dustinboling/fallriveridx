class Api::PropertiesController < ApplicationController
  # TODO: figure out how to dry this up.
  include Api::Shared::ErrorsHelper
  include Api::Shared::LoggerHelper

  require 'socket'

  before_filter :validate_params
  before_filter :authenticate_referrer

  ACCEPTABLE_PARAMS = ["ListingID", "FullStreetAddress", "City", "ZipCode", 
    "BuildersTractName", "ListAgentAgentID", "SaleAgentAgentID", "ListPrice", 
    "BedroomsTotal", "BathsTotal", "BuildingSize", "Limit", "controller", 
    "action", "format", "Token"]

  def search
    # construct SQL query
    if @user_params.keys.count == 0
      Batsd.increment(:request => request, :success => false, :error_type => :params)
      respond_error("No parameters supplied.")
    else
      query = "SELECT * FROM listings WHERE "
      @user_params.each do |key, value|
        if /ListPrice/.match(key)
          price_exp = "/\A" + params[:ListPrice] + "/"
          if price_exp.match('>')
            query = query + "\"ListPrice\" > '#{value[1..-1]}' AND "
          elsif price_exp.match('<')
            query = query + "\"ListPrice\" < '#{value[1..-1]}' AND "
          else
            Batsd.increment(:request => request, :success => false, :error_type => :params)
            respond_error("Could not parse ListPrice.")
          end 
        elsif /BathsTotal/.match(key) || /BedroomsTotal/.match(key) || /BuildingSize/.match(key)
          query = query + "\"#{key}\" >= '#{value}' AND "
        elsif /Limit/.match(key)
          @query_limit = " LIMIT #{value}"
        else
          query = query + "\"#{key}\" = '#{value}' AND "
        end
      end

      # check to see query has been modified, make it into an acceptable SQL query, add limit
      # note that default limit is currently set to 15
      query_exp = "/\A" + query + "/" 
      if query_exp.match("AND ") && @query_limit
        query = query[0..-6]
        query = query + @query_limit + ";"
      elsif query_exp.match("AND ")
        query = query[0..-6]
        query = query + " LIMIT 15" + ";"
      else
        Batsd.increment(:request => request, :success => false, :error_type => :params)
        respond_error("No parameters supplied.")
      end

      if query == "SELECT * FROM listings WHERE "
        Batsd.increment(:request => request, :success => false, :error_type => :params)
        respond_error("No parameters supplied")
      else
        # push listings to view
        @listings = Listing.find_by_sql(query)

        # log to batsd
        Batsd.increment(:request => request, :success => true)
      end
    end
  end

  def show  
    # This action currently only supports the ListingID field OR FullStreetAddress (plus Token for authentication).
    # Listing ID is preferred as it is a better, more performant key.
    if params[:ListingID]
      @listing = Listing.where(:ListingID => params[:ListingID]) 
      Batsd.increment(:request => request, :success => true)
    elsif params[:FullStreetAddress]
      @listing = Listing.where(:FullStreetAddress => params[:FullStreetAddress])
      Batsd.increment(:request => request, :success => true)
    end
  end

  def invalid_parameters
  end

  ###
  # filters
  def validate_params
    @user_params = {}
    params.each do |key, value|
      if ACCEPTABLE_PARAMS.include?(key)
        if /action/.match(key) || /controller/.match(key) || /format/.match(key) || /Token/.match(key)
          # do nothing
        else
          @user_params["#{key}"] = value
        end
      else
        Batsd.increment(:request => request, :success => false)
        respond_error("The following parameter is invalid: #{key}")
      end
    end
  end

  # change @user to user unless we need the instance varible up above
  def authenticate_referrer
    if params[:Token] == "" || nil
      Batsd.increment(:request => request, :success => false)
      respond_error("You have not supplied a token")
    elsif User.find_by_authentication_token(params[:Token])
      @user = User.find_by_authentication_token(params[:Token])

      if @user.authentication_token == "NULL"
        Batsd.increment(:request => request, :success => false, :error_type => :auth)
        respond_error("Your token is invalid. Please make sure your subscription is still active.")
      elsif @user.site_url != request.env["HTTP_REFERER"]
        Batsd.increment(:request => request, :success => false, :error_type => :referer)
        respond_error("This site (#{request.env["HTTP_REFERER"]}) is not activated. Please activate this site, then try again.")
      elsif @user.site_url == "NULL"
        Batsd.increment(:request => request, :success => false, :error_type => :referer)
        respond_error("You have not activated a site on this token yet.") 
      end
    else
      Batsd.increment(:request => request, :success => false, :error_type => :auth)
      respond_error("Could not find an account with this API key. Please verify and update your API key.")
    end
  end

  def resolve_site_url
  end
end

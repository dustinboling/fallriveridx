class Api::PropertiesController < ApplicationController
  include Api::Shared::ErrorsHelper

  before_filter :validate_params
  before_filter :authenticate_referrer

  ACCEPTABLE_PARAMS = ["SiteUrl", "ListingID", "City", "ZipCode", "BuildersTractName", "ListAgentAgentID", "SaleAgentAgentID", "ListPrice", "BedroomsTotal", "BathsTotal", "BuildingSize", "Limit", "controller", "action", "format", "Token"]

  def search
    # construct SQL query
    if @user_params.keys.count == 0
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
        respond_error("No parameters passed to query.")
      end

      if query == "SELECT * FROM listings WHERE "
        respond_error("No parameters supplied")
      else
        @listings = Listing.find_by_sql(query)
      end
    end
  end

  def show  
    # This action currently only supports the ListingID field (plus Token for authentication).
    # ListingID is our primary key field unless we find a problem with it. 
    @listing = Listing.where(:ListingID => params[:ListingID]) 
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
        elsif !params.include?("SiteUrl")
          respond_error("You must include the SiteUrl parameter")
        else
          @user_params["#{key}"] = value
        end
      else
        respond_error("The following parameter is invalid: #{key}")
      end
    end
  end

  # change @user to user unless we need the instance varible up above
  def authenticate_referrer
    if params[:Token] == "" || nil
      respond_error("You have not supplied a token")
    elsif User.find_by_authentication_token(params[:Token])
      @user = User.find_by_authentication_token(params[:Token])

      if @user.authentication_token == "NULL"
        respond_error("Your token is invalid. Please make sure your subscription is still active.")
      elsif @user.site_url != params[:SiteUrl]
        respond_error("This site (#{request.referer}) is not activated. Please activate this site, then try again.")
      elsif @user.site_url == "NULL"
        respond_error("You have not activated a site on this token yet.") 
      end
    else
      respond_error("Could not find an account with this API key. Please verify and update your API key.")
    end
  end
end

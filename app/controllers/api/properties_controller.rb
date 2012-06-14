class Api::PropertiesController < ApplicationController
  include Api::Shared::ErrorsHelper
  include Api::Shared::BatsdHelper

  require 'socket'

  before_filter :validate_params
  before_filter :authenticate_referrer

  ACCEPTABLE_PARAMS = ["SortBy", "ListingID", "ListingStatus", "FullStreetAddress", "City", 
    "ZipCode", "BuildersTractName", "ListAgentAgentID", "SaleAgentAgentID", 
    "ListPrice", "BedroomsTotal", "BathsTotal", "BuildingSize", "Limit", 
    "controller", "action", "format", "Token"]

  def search_summary
  end

  def search
    # construct SQL query
    if @user_params.keys.count == 0
      batsd_log_error(:type => :params)
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
            batsd_log_error(:type => :params)
            respond_error("Could not parse ListPrice.")
          end 
        elsif /BathsTotal/.match(key) || /BedroomsTotal/.match(key) || /BuildingSize/.match(key)
          query = query + "\"#{key}\" >= '#{value}' AND "
        elsif /SortBy/.match(key)
          value_ary = value.split('|')
          column = value_ary[0]
          direction = value_ary[1]
          if /AND \z/.match(query)
            @order_by = "ORDER BY \"#{column}\" #{direction}"
          else
            @order_by = "ORDER BY \"#{column}\" #{direction}"
          end
        elsif /Limit/.match(key)
          @query_limit = " LIMIT #{value}"
        else
          query = query + "\"#{key}\" = '#{value}' AND "
        end
      end

      # remove trailing AND
      if /AND \Z/.match(query)
        query = query.gsub(/AND \Z/, "")  
      end

      # check to see query has been modified, make it into an acceptable SQL query, add limit
      # note that default limit is currently set to 15
      if /AND \A/.match(query) && @query_limit
        query = query[0..-6]
        query = query + @query_limit + ";"
      elsif /AND \A/.match(query)
        query = query[0..-6]
        query = query + " LIMIT 15" + ";"
      elsif @order_by && @query_limit
        query = query + @order_by + @query_limit + ";"
      elsif @order_by
        query = query + @order_by + ";"
      else
        batsd_log_error(:type => :params)
        respond_error("No parameters supplied.")
      end

      if query == "SELECT * FROM listings WHERE "
        batsd_log_error(:type => :params)
        respond_error("No parameters supplied")
      else
        # push listings to view
        @listings = Listing.find_by_sql_with_associations(query)

        # log to batsd
        batsd_log_success
      end
    end
  end

  def show  
    # This action currently only supports the ListingID field OR FullStreetAddress (plus Token for authentication).
    # Listing ID is preferred as it is a better, more performant key.
    if params[:ListingID]
      @listing = Listing.where(:ListingID => params[:ListingID]) 
      batsd_log_success
    elsif params[:FullStreetAddress]
      @listing = Listing.where(:FullStreetAddress => params[:FullStreetAddress])
      batsd_log_success
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
        batsd_log_error(:type => :params)
        respond_error("The following parameter is invalid: #{key}")
      end
    end
  end

  # change @user to user unless we need the instance varible up above
  def authenticate_referrer
    if params[:Token] == "" || nil
      batsd_log_error(:type => :auth)
      respond_error("You have not supplied a token")
    elsif User.find_by_authentication_token(params[:Token])
      @user = User.find_by_authentication_token(params[:Token])

      if @user.authentication_token == "NULL"
        batsd_log_error(:type => :auth)
        respond_error("Your token is invalid. Please make sure your subscription is still active.")
      elsif @user.site_url != request.env["HTTP_REFERER"]
        batsd_log_error(:type => :referer)
        respond_error("This site has not been activated")
      elsif @user.site_url == "NULL"
        batsd_log_error(:type => :referer)
        respond_error("You have not activated a site on this token yet.") 
      end
    else
      batsd_log_error(:type => :auth)
      respond_error("Could not find an account with this API key. Please verify and update your API key.")
    end
  end
end

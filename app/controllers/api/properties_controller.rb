class Api::PropertiesController < ApplicationController
  include Api::PropertiesHelper

  ACCEPTABLE_PARAMS = ["City", "ZipCode", "ListAgentAgentID", "ListPrice", "BedroomsTotal", "BathsTotal", "LotSizeSQFT", "controller", "action", "format"]

  def search
    user_params = {}
    # throw acceptable params into the user_params hash, respond with bad request if necessary
    params.each do |key, value|
      if ACCEPTABLE_PARAMS.include?(key)
        if /action/.match(key) || /controller/.match(key) || /format/.match(key)
          # do nothing
        else
          user_params["#{key}"] = value
        end
      else
        respond_error("The following parameter is invalid: #{key}")
      end
    end

    # construct SQL query
    if user_params.keys.count == 0
      respond_error("No parameters supplied.")
    else
      query = "SELECT * FROM listings WHERE "
      user_params.each do |key, value|
        if /ListPrice/.match(key)
          price_exp = "/\A" + params[:ListPrice] + "/"
          if price_exp.match('>')
            query = query + "\"ListPrice\" > '#{value[1..-1]}' AND "
          elsif price_exp.match('<')
            query = query + "\"ListPrice\" < '#{value[1..-1]}' AND "
          else
            respond_error("Could not parse ListPrice.")
          end 
        elsif /BathsTotal/.match(key) || /BedroomsTotal/.match(key) || /LotSizeSQFT/.match(key)
          query = query + "\"#{key}\" >= '#{value}' AND "
        else
          query = query + "\"#{key}\" = '#{value}' AND "
        end
      end

      # check to see query has been modified, make it into an acceptable SQL query
      # this part may be unnecessary (the statement portion)
      query_exp = "/\A" + query + "/" 
      if query_exp.match("AND ")
        query = query[0..-6]
        query = query + ";"
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
    # This action currently only supports the ListingID field. 
    # ListingID is our primary key field unless we find a problem with it.
    @listing = Listing.where(:ListingID => params[:ListingID]) 
  end

  def invalid_parameters
  end
end
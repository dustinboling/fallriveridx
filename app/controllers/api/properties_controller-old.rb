class Api::PropertiesController < ApplicationController
  include Api::PropertiesHelper

  ACCEPTABLE_PARAMS = ["City", "ListAgentAgentID", "ListPrice", "controller", "action", "format"]

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

    # construct query.
    if user_params.keys.count == 0
      respond_error("No parameters supplied.")
    else
      query = {}
      user_params.each do |key, value|
        if /ListPrice/.match(key)
          price_exp = "/\A" + params[:ListPrice] + "/"
          if price_exp.match('>')
            @list_price_greater_than = true
            @list_price = params[:ListPrice][1..-1]
          elsif price_exp.match('<')
            @list_price_greater_than = false
            @list_price = params[:ListPrice][1..-1] 
          else
            respond_error("Could not parse ListPrice.")
          end 
        elsif /BathsTotal/.match(key)
          @baths_greater_than = true
          @baths_total = value
        elsif /BedroomsTotal/.match(key)
          @bedrooms_greater_than = true
          @beds_total = value
        elsif /LotSizeSQFT/.match(key)
          @lot_size_greater_than = true 
          @lot_size = value
        else
          query["#{key}"] = value
        end
      end
      # figure out what to make the query
      # TODO: convert above to raw SQL and just execute the query string using find_by_sql
      # a statement this long can't be a good thing. Raw SQL should be faster as well.
      if @list_price_greater_than == true && @baths_greater_than && @beds_greater_than && @lot_size_greater_than
        @listings = Listing.where(query).greater_than("ListPrice", @list_price).greater_than("BathsTotal", @baths_total).greater_than("BedroomsTotal", @beds_total).greater_than("LotSizeSQFT", @lot_size)
      elsif @list_price_greater_than == false && @baths_greater_than && @beds_greater_than && @lot_size_greater_than
        @listings = Listing.where(query).less_than("ListPrice", @list_price).greater_than("BathsTotal", @baths_total).greater_than("BedroomsTotal", @beds_total).greater_than("LotSizeSQFT", @lot_size)
      elsif @list_price_greater_than == true && @baths_greater_than && @beds_greater_than
        @listings = Listing.where(query).greater_than("ListPrice", @list_price).greater_than("BathsTotal", @baths_total).greater_than("BedroomsTotal", @beds_total)
      elsif @list_price_greater_than == false && @baths_greater_than && @beds_greater_than
        @listings = Listing.where(query).less_than("ListPrice", @list_price).greater_than("BathsTotal", @baths_total).greater_than("BedroomsTotal", @beds_total)
      elsif @list_price_greater_than == true && @baths_greater_than
        @listings = Listing.where(query).greater_than("ListPrice", @list_price).greater_than("BathsTotal", @baths_total)
      elsif @list_price_greater_than == false && @baths_greater_than
        @listings = Listing.where(query).less_than("ListPrice", @list_price).greater_than("BathsTotal", @baths_total)
      elsif @list_price_greater_than == true && @beds_greater_than
        @listings = Listing.where(query).greater_than("ListPrice", @list_price).greater_than("BedroomsTotal", @beds_total)
      elsif @list_price_greater_than == false && @beds_greater_than
        @listings = Listing.where(query).less_than("ListPrice", @list_price).greater_than("BedroomsTotal", @beds_total)
      elsif @list_price_greater_than == true && @lot_size_greater_than
        @listings = Listing.where(query).greater_than("ListPrice", @list_price).greater_than("LotSizeSQFT", @lot_size)
      elsif @list_price_greater_than == false && @lot_size_greater_than
        @listings = Listing.where(query).less_than("ListPrice", @list_price).greater_than("LotSizeSQFT", @lot_size)
      elsif @list_price_greater_than == true
        @listings = Listing.where(query).greater_than("ListPrice", @list_price)
      elsif @list_price_greater_than == false
        @listings = Listing.where(query).less_than("ListPrice", @list_price)
      elsif @baths_greater_than && @beds_greater_than && @lot_size_greater_than
        @listings = Listing.where(query).greater_than("BathsTotal", @baths_total).greater_than("BedroomsTotal", @beds_total).greater_than("LotSizeSQFT", @lot_size)
      elsif @baths_greater_than && @beds_greater_than
        @listings = Listing.where(query).greater_than("BathsTotal", @baths_total).greater_than("BedroomsTotal", @beds_total)
      elsif @baths_greater_than && @lot_size_greater_than
        @listings = Listing.where(query).greater_than("BathsTotal", @baths_total).greater_than("LotSizeSQFT", @lot_size)
      elsif @beds_greater_than && @lot_size_greater_than
        @listings = Listing.where(query).greater_than("BedroomsTotal", @beds_total).greater_than("LotSizeSQFT", @lot_size)
      elsif @baths_greater_than
        @listings = Listing.where(query).greater_than("BathsTotal", @baths_total)
      elsif @beds_greater_than
        @listings = Listing.where(query).greater_than("BedroomsTotal", @beds_total)
      elsif @lot_size_greater_than
        @listings = Listing.where(query).greater_than("LotSizeSQFT", @lot_size)
      else
        @listings = Listing.where(query).limit(20)
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

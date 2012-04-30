class Api::PropertiesController < ApplicationController
  include Api::PropertiesHelper

  def index
    # check params against the acceptable list
    acceptable_params = ["City", "AgentID", "controller", "action", "format"]

    # respond with bad request if necessary
    params.each do |key, value|
      if acceptable_params.include?(key)
        # do nothing
      else
        respond_error("The following parameter is invalid: #{key}")
      end
    end

    # populate listings according to params
    # if params include "AgentID" we are searching only for an agent's properties
    if params.count <= 3
      respond_error("No parameters supplied.")
    elsif params.include?("AgentID")
      @listings = Listing.where(:ListAgentAgentID => params[:AgentID])
    else
      @listings = Listing.where(:City => params[:City])
    end
  end

  def show
    @listing = Listing.where(:ListingID => params[:ListingID]) 

    respond_to do |format|
      format.json
    end
  end

  def invalid_parameters
  end
end

class Api::AccountsController < ApplicationController
  include Api::Shared::ErrorsHelper

  before_filter :set_acceptable_params
  before_filter :validate_params

  def show
    if User.find_by_authentication_token(params[:Token])
      @user = User.find_by_authentication_token(params[:Token])
    elsif !params[:Token]
      respond_error("No token supplied.")
    else
      respond_error("Authentication token invalid.")
    end 
  end

  def create
    # # set a temporary password
    # chars = ("a".."z").to_a + ("A".."Z").to_a + (1..9).to_a 
    # password = Array.new(8, '').collect {chars[rand(chars.size)]}.join

    # # sign up user
    # @user = User.new(:username => params[:email], :password => password, :password_confirmation => password)
    # @user.save
  end

  def update
    if User.find_by_authentication_token(params[:Token])
      @user = User.find_by_authentication_token(params[:Token])

      @user.site_url = params[:SiteUrl]
      @user.site_ip_address = request.remote_ip

      if @user.save
        respond_success("You have activated your subscription for this site.")
      else
        respond_error("There has been an error with your request, please try again.")
      end
    else 
      respond_error("Invalid API key.")
    end
  end

  def invalid_parameters
  end

  ###
  # filters
  def set_acceptable_params
    case action_name
    when "show"
      @acceptable_params = ["Token", "controller", "action", "format"]
      
      if !params.include?("Token")
        respond_error("You did not include a Token.")
      end
    when "create"
      @acceptable_params = ["username", "email", "controller", "action", "format"]

      if !params.include?("username")
        respond_error("You did not include a username.")
      elsif !params.include?("email")
        respond_error("You did not include an email address.")
      end
    when "update"
      @acceptable_params = ["SiteUrl", "Token", "controller", "action", "format"]
    end
  end

  def validate_params
    @user_params = {}

    params.each do |key, value|
      if @acceptable_params.include?(key)
        if /action/.match(key) || /controller/.match(key) || /format/.match(key) || /Token/.match(key)
          # do nothing
        elsif !params.include?("SiteUrl")
          respond_error("You did not include a SiteUrl.")
        else
          @user_params["#{key}"] = value
        end
      else
        respond_error("The following parameter is invalid: #{key}")
      end
    end
  end
end

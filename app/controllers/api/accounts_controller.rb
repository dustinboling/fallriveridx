class Api::AccountsController < ApplicationController
  include Api::Shared::ErrorsHelper

  before_filter :set_acceptable_params
  before_filter :validate_params

  def create
    @user = User.new
    @user.username = params[:username]
    @user.email = params[:email]
    # set password
    # save
    # send password through mailer
  end

  def update
  end

  def invalid_parameters
  end

  ###
  # filters
  def set_acceptable_params
    case action_name
    when "create"
      @acceptable_params = ["username", "email", "controller", "action", "format"]

      if !params.include?("username")
        respond_error("You did not include a username.")
      elsif !params.include?("email")
        respond_error("You did not include an email address.")
      end
    when "update"
      @acceptable_params = ["site_url", "controller", "action", "format"]
    end
  end

  def validate_params
    @user_params = {}
    params.each do |key, value|
      if @acceptable_params.include?(key)
        if /action/.match(key) || /controller/.match(key) || /format/.match(key) || /Token/.match(key)
          # do nothing
        else
          @user_params["#{key}"] = value
        end
      else
        respond_error("The following parameter is invalid: #{key}")
      end
    end
  end

end

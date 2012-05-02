module Api::PropertiesHelper
  def respond_error(msg)
    respond_to do |format|
      format.json {
        flash[:message] = msg
        render :invalid_parameters
      }
    end
  end

  def validate_parameters
    user_params = {}
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
  end

  # trying to do this without URI module for now to limit overhead.
  def authenticate_referrer
    user = User.find_by_authentication_token(params[:Token])
    if user.authentication_token == NULL
      respond_error("Your token is invalid. Please make sure your account is still active.")
    elsif user.site_url != request.referer
      respond_error("This site #{request.referer} is not activated. Please deactivate #{user.site_url} first.") 
    elsif user.site_url == NULL
      respond_error("You have not activated a site on this token yet.") 
    end
  end
end

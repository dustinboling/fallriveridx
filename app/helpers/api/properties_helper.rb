module Api::PropertiesHelper
  def respond_error(msg)
    respond_to do |format|
      format.json {
        flash[:message] = msg
        render :invalid_parameters
      }
    end
  end

end

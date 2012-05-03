module Api::Shared::ErrorsHelper
  def respond_error(msg)
    respond_to do |format|
      format.json {
        flash[:message] = msg
        render :respond_fail
      }
    end
  end

  def respond_success(msg)
    respond_to do |format|
      format.json {
        flash[:message] = msg
        render :respond_success
      }
    end
  end
end

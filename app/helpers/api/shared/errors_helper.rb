module Api::Shared::ErrorsHelper
  def respond_error(msg)
    flash[:message] = msg
    render :respond_fail and return
  end

  def respond_success(msg)
    flash[:message] = msg
    render :respond_success and return
  end
end

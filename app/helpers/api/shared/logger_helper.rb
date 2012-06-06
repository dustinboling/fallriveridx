module Api::Shared::LoggerHelper
  def batsd_increment
    # compose counter
    ctr_token = @user.authentication_token
    ctr_req = params[:controller] + '.' + params[:action]
    counter = ctr_token + "." + ctr_req

    # log stat
    $statsd.increment(counter)
  end

  def batsd_log_failure
  end
end

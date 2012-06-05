module Api::Shared::LoggerHelper
  def batsd_increment
    # compose counter name
    ctr_token = @user.authentication_token
    ctr_req = params[:controller] + '.' + params[:action]
    ctr_params = ""
    @user_params.each do |key, value|
      ctr_params = ctr_params +  key + ":" + value
    end
    counter = ctr_token + '.get' + ctr_req +  "." + ctr_params

    # log stat
    $statsd.increment(counter)
  end

  def batsd_log_failure
  end
end

module Api::Shared::LoggerHelper
  def batsd_increment
    # compose counter name
    ctr_token = @user.authentication_token
    ctr_req = params[:controller] + '.' + params[:action]
    ctr_params = ""
    @user_params.each_with_index do |(key, value), index|
      key = key.to_s
      value = value.to_s
      if index == @user_params.length - 1
        ctr_params = ctr_params + key + "=" + value
      else
        ctr_params = ctr_params + key + "=" + value + "&"
      end
    end
    counter = ctr_token + '.get' + ctr_req +  "." + ctr_params

    # log stat
    $statsd.increment(counter)
  end

  def batsd_log_failure
  end
end

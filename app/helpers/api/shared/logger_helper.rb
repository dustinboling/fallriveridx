module Api::Shared::LoggerHelper
  def batsd_increment(options={})
    # compose counter
    ctr_token = @user.authentication_token
    ctr_req = params[:controller] + '.' + params[:action]

    if options[:success] == false
      @counter = ctr_token + "." + ctr_req + ".fail"
    else
      @counter = ctr_token + "." + ctr_req + ".success"
    end

    # log stat
    $statsd.increment(@counter)
  end

  def batsd_log_failure
  end
end

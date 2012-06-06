module Api::Shared::LoggerHelper
  def batsd_increment(options={})
    # compose counter
    if !@user
      if !request.env["HTTP_REFERER"]
        @ctr_token = "UNKNOWN"
      else
        @ctr_token = "UNKOWN@" request.env["HTTP_REFERER"]
      end
    else
      @ctr_token = @user.authentication_token
    end
    ctr_req = params[:controller] + '.' + params[:action]
    counter = @ctr_token + "." + ctr_req

    if options[:success] == false
      counter = counter + ".fail"
    elsif options[:success] == true
      counter = counter + ".success"
    end

    # log stat
    $statsd.increment(counter)
  end

  def batsd_log_failure
  end
end

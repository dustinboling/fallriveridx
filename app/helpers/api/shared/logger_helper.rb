module Api::Shared::LoggerHelper
  def batsd_increment
        # compose counter name
        ctr_site = request.env["HTTP_REFERER"]
        ctr_site = @user.site_url
        ctr_details = params[:controller] + '.' + params[:action]
        counter = ctr_site + '.get' + ctr_details
    $statsd.increment(counter)
  end

  def batsd_log_failure
  end
end

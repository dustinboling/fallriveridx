module Api::Shared::LoggerHelper
  def batsd_increment(counter)
    $statsd.increment(counter)
  end

  def batsd_log_failure
  end
end

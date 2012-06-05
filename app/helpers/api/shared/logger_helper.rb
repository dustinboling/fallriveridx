module Api::Shared::LoggerHelper
  def batsd_increment(counter)
    $statsd.increment()
  end

  def batsd_log_failure
  end
end

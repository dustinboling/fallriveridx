module Api::Shared::LoggerHelper
  # This module attempts to do as much logging as possible with as few methods
  # as possible. The idea is to keep as calls to the logger as possible. 
  # TODO: move logger calls into respond_error and respond_success
  module Batsd
    # Dynamically increments a batsd counter based on HTTP_REFERER 
    # :success => boolean (was the request successful?)
    # :error_type => :auth, :referer, :params
    def self.increment(options={})
      request ||= nil
      if !options[:request].nil?
        request = options[:request]
      end

      if @user == nil
        if !request.env["HTTP_REFERER"]
          @ctr_token = "UNKNOWN"
        else
          http_ref = request.env["HTTP_REFERER"].gsub(/http[s]?:\/\//, "")
          @ctr_token = "UNKOWN-at-" + http_ref
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

      if options[:error_type] == :auth
        counter = counter + ".auth"
      elsif options[:error_type] == :referer
        counter = counter + ".referer"
      elsif options[:error_type] == :params
        counter = counter + ".params"
      end

      # log stat
      $statsd.increment(counter)
    end
  end

  def batsd_increment(options={})
    # resolve user token / user not valid
    if @user == nil
      if !request.env["HTTP_REFERER"]
        @ctr_token = "UNKNOWN"
      else
        http_ref = request.env["HTTP_REFERER"].gsub(/http[s]?:\/\//, "")
        @ctr_token = "UNKOWN-at-" + http_ref
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
end

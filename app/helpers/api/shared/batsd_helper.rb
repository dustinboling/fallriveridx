module Api::Shared::BatsdHelper
  # TODO: move logger calls into respond_error and respond_success
  # TODO: make this less totally insane. Should be able to just call Batsd.increment
  # This module attempts to do as much logging as possible with as few methods
  # as possible. The idea is to keep as calls to the logger as possible. 

  # Options setters to get around scope issues.
  # TODO: try making request, params referer attr_accessible, then push everything down into Batsd module
  def batsd_log_error(options={})
    opts = {}
    if @user
      opts[:auth_token] = @user.authentication_token
    else
      opts[:auth_token] = nil
    end
    opts[:success] = false
    opts[:referer] = request.env["HTTP_REFERER"]
    opts[:controller] = params[:controller]
    opts[:action] = params[:action]
    @ip = request.env['REMOTE_ADDR']

    if options[:type] == :referer
      opts[:error_type] = :referer
    elsif options[:type] == :auth
      opts[:error_type] = :auth
    elsif options[:type] == :params
      opts[:error_type] = :params
    elsif options[:type] == :unknown
      opts[:error_type] = :unknown
    end
    Batsd.increment(opts)
  end

  def batsd_log_success
    opts = {}
    if @user
      opts[:auth_token] = @user.authentication_token
    else
      opts[:auth_token] = nil
    end
    opts[:success] = true
    opts[:referer] = request.env["HTTP_REFERER"]
    opts[:controller] = params[:controller]
    opts[:action] = params[:action]

    Batsd.increment(opts)
  end

  # Dynamically increments a batsd counter based on HTTP_REFERER 
  # :success => boolean (was the request successful?)
  # :error_type => :auth, :referer, :params
  module Batsd
    def self.increment(options={})
      if options[:auth_token] == nil
        if options[:referer] == nil
          @ctr_token = "UNKNOWN"
        else
          http_ref = options[:referer].gsub(/http[s]?:\/\//, "")
          @ctr_token = "UNKOWN-at-" + http_ref
        end
      else
        @ctr_token = options[:auth_token]
      end
      ctr_req = options[:controller] + '.' + options[:action]
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
      elsif options[:error_type] == :unknown
        counter = counter + ".unkown"
      end

      # log stat
      $statsd.increment(counter)
    end
  end
end

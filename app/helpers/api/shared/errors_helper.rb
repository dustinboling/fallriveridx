module Api::Shared::ErrorsHelper
  # Submodule that calls up to parent module redirects. Also wraps up the 
  # batsd calls nicely so they aren't littered around the controllers.
  # NOTE: you have to put params and request hash into instance variables or
  # they will not be available to this module.
  # :type => :auth, :referer, :params (possibly divert this into :params_nil and :params_invalid)
  module IdxError
    def self.log(options={})
      if options[:type] == :params
        err_opts = {}
        err_opts[:success] = false
        err_opts[:error_type] = :params
        err_opts[:params] = options[:params]
        err_opts[:request] = options[:request]

        Batsd.increment(err_opts)
        respond_error("No parameters supplied.")
      elsif options[:type] == :referer
        err_opts = {}
        err_opts[:success] = false
        err_opts[:error_type] = :params
        err_opts[:params] = @params
        err_opts[:request] = @request

        Batsd.increment(err_opts)
        respond_error("This site (#{request.env["HTTP_REFERER"]}) is not activated. Please activate on this site, then try again.")
      elsif options[:type] == :auth
        Batsd.increment(:success => false, :error_type => :referer)
        respond_error("Invalid token.")
      end
    end

    module Batsd
      def self.increment(options={})
        if !options[:request].nil?
          request = options[:request]
        elsif !options[:params].nil?
          params = options[:params]
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

    private
    def set_opts

    end
  end

  ###
  # Class methods
  def respond_error(msg)
    respond_to do |format|
      format.json {
        flash[:message] = msg
        render :respond_fail and return
      }
    end
  end

  def respond_success(msg)
    respond_to do |format|
      format.json {
        flash[:message] = msg
        render :respond_success and return
      }
    end
  end
end

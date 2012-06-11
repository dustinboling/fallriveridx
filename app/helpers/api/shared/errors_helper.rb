module Api::Shared::ErrorsHelper
  # Submodule that calls up to parent module redirects. Also wraps up the 
  # batsd calls nicely so they aren't littered around the controllers.
  # :type => :auth, :referer, :params (possibly divert this into :params_nil and :params_invalid)
  module IdxError
    def error(options={})
      if options[:type] == :params
        Batsd.increment(:success => false, :error_type => :params)
        respond_error("No parameters supplied.")
      elsif options[:type] == :referer
        Batsd.increment(:success => false, :error_type => :referer)
        respond_error("This site (#{request.env["HTTP_REFERER"]}) is not activated. Please activate on this site, then try again.")
      elsif options[:type] == :auth
        Batsd.increment(:success => false, :error_type => :referer)
        respond_error("Invalid token.")
      end
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

module Api::GeocodeHelper
  def add_limit
    if @query_limit
      @query = @query + @query_limit
    else
      @query = @query + " LIMIT 20"
    end  
  end
end

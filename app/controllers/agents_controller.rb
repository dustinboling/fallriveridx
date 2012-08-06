class AgentsController < ApplicationController

  def new
    @agent = Agent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @agent }
    end
  end

  def create
    @agent = Agent.new(params[:agent])

    respond_to do |format|
      if @agent.save
        format.html { redirect_to @agent, notice: 'Agent was successfully created.' }
        format.json { render json: @agent, status: :created, location: @agent }
      else
        format.html { render action: "new" }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @agent = Agent.find(params[:id])

    respond_to do |format|
      if @agent.update_attributes(params[:agent])
        format.html { redirect_to @agent, notice: 'Agent was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @agent = Agent.find(params[:id])
    @agent.destroy

    respond_to do |format|
      format.html { redirect_to agents_url }
      format.json { head :ok }
    end
  end
end

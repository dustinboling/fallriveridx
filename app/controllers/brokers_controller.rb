class BrokersController < ApplicationController

  def new
    @broker = Broker.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @broker }
    end
  end

  def create
    @broker = Broker.new(params[:broker])

    respond_to do |format|
      if @broker.save
        format.html { redirect_to @broker, notice: 'Broker was successfully created.' }
        format.json { render json: @broker, status: :created, location: @broker }
      else
        format.html { render action: "new" }
        format.json { render json: @broker.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @broker = Broker.find(params[:id])

    respond_to do |format|
      if @broker.update_attributes(params[:broker])
        format.html { redirect_to @broker, notice: 'Broker was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @broker.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @broker = Broker.find(params[:id])
    @broker.destroy

    respond_to do |format|
      format.html { redirect_to brokers_url }
      format.json { head :ok }
    end
  end
end

class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_back_or_to root_url, :notice => "You have logged in."
    else
      flash[:notice] = "Email or password was incorrect."
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to root_url, :notice => "You have logged out."
  end

end

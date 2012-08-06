class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.new_api_key_email(@user).deliver
      redirect_to root_url, :notice => "You have signed up successfully!"
    else
      render :new
    end
  end

end

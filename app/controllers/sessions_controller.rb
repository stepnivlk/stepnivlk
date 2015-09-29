class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "Successfully logged in"
      log_in(user)
      redirect_to user
    else
      flash.now[:warning] = "Unable to log in"
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:success] = "Successfully logged out"
    redirect_to root_url
  end
end

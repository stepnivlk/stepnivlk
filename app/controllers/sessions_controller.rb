class SessionsController < ApplicationController
  skip_before_action :logged_in_user

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "Successfully logged in"
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:warning] = "Unable to log in"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "Successfully logged out"
    redirect_to root_url
  end
end

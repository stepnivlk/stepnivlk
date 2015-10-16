class SessionsController < ApplicationController
  skip_before_action :logged_in_user

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "Přihlášení proběhlo úspěšně."
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:warning] = "Přihlášení bylo neůspěšné."
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "Odhlášení proběhlo úspěšně."
    redirect_to root_url, anchor: "firstinfo"
  end
end

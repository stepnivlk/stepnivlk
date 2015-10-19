class ApplicationController < ActionController::Base
  before_action :logged_in_user
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # include sessions_helper.rb, used for working with current user session.
  include SessionsHelper

  # Checks if someone is logged in, redirects to login url if not.
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Prosím přihlašte se."
      redirect_to login_url
    end
  end
end

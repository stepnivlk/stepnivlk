class ApplicationController < ActionController::Base
  before_action :logged_in_user
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # def logged_in_admin
  #   unless logged_in_admin?
  #     flash[:danger] = "Please log in."
  #     redirect_to login_url
  #   end
  # end
end

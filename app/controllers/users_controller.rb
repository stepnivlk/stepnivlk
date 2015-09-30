class UsersController < ApplicationController
  before_action :logged_in_admin, only: [:new, :create]
  before_action :find_user, only: [:show]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "New user was successfully signed up."
      redirect_to @user
    else
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def find_user
      @user = User.find(params[:id])
    end

end

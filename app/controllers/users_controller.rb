class UsersController < ApplicationController
  skip_before_action :logged_in_user, only: [:show]
  before_action :find_user, only: [:show, :edit, :update]

  def show
    @simple_user_infos = @user.simple_user_infos

    respond_to do |format|
      format.html
      format.pdf do
        pdf = CvPdf.new(@user)
        send_data pdf.render, filename: "#{I18n.transliterate(@user.real_name).gsub(" ", "_").downcase}_cv_#{Time.now.strftime("%Y%m%d")}.pdf", type: 'application/pdf'
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Nový uživatel byl úspěšně přihlášen."
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update user_params
      flash[:success] = "Uživatel byl úspěšně aktualizován."
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(
              :name, :email, :password, :password_confirmation, :avatar, 
              :birth_date, :real_name, :phone, :admin,
              simple_user_infos_attributes: [:info, :_destroy, :id],
              skills_attributes: [:skill, :skill_index, :in_love_index, :_destroy, :id],
              educations_attributes: [:start, :end, :name, :body, :_destroy, :id],
              experiences_attributes: [:start, :end, :name, :body, :_destroy, :id])
    end

    def find_user
      @user = User.find(params[:id])
    end

end

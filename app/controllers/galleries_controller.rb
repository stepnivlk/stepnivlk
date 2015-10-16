class GalleriesController < ApplicationController
  skip_before_action :logged_in_user, only: [:index, :show]
  before_action :find_gallery, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: :destroy

  def index
    if logged_in? 
      @galleries = Gallery.all.order("created_at desc")
    else
      @galleries = Gallery.where(public: true).order("created_at desc")
    end
  end

  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = current_user.galleries.build(gallery_params)

    if @gallery.save
      if params[:images]
        params[:images].each { |image| @gallery.images.create(file: image)}
      end
      flash[:success] = "Vaše galerie byla úspěšně uložena."
      redirect_to @gallery
    else
      flash.now[:warning] = "Vaše galerie nebyla uložena, zkuste to znovu."
      render 'new'
    end
  end

  def show
  end

  def destroy
    @gallery.destroy
    redirect_to galleries_path
  end

  private

    def gallery_params
      params.require(:gallery).permit(:name, :description, :images, :public)
    end

    def find_gallery
      @gallery = Gallery.find(params[:id])
    end

    def correct_user
      unless @gallery.user == current_user || current_user.admin
        flash[:danger] = "Nemáte oprávnění k provedení této operace."
        redirect_to(galleries_path)
      end
    end
end

class GalleriesController < ApplicationController
  skip_before_action :logged_in_user, only: [:index, :show]
  before_action :find_gallery, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  respond_to :html, :js

  def index
    @galleries = scoped_index(Gallery)
  end

  def new
    @gallery = Gallery.new
  end

  def create
    respond_to do |format|
      @gallery = current_user.galleries.build(gallery_params)
      if @gallery.save
        if params[:images]
          params[:images].each { |image| @gallery.images.create(file: image)}
        end
        format.html { redirect_to @gallery }
        format.js
      else
        format.html do
          flash.now[:warning] = "Vaše galerie nebyla uložena, zkuste to znovu."
          render 'new'
        end
        format.js
      end
    end
  end

  def show
    @images = @gallery.images.paginate(page: params[:page], per_page: 25)
    store_location
    unless @gallery.public
      correct_user
    end
  end

  def edit

  end

  def update
    respond_to do |format|
      if @gallery.update gallery_params
        if params[:images]
          params[:images].each { |image| @gallery.images.create(file: image)}
        end
        format.html { redirect_to @gallery }
        format.js
      else
        format.html do
          flash.now[:warning] = "Vaše galerie nebyla uložena, zkuste to znovu."
          render 'edit'
        end
        format.js
      end
    end
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
      unless @gallery.user == current_user || logged_in_admin?
        flash[:danger] = "Nemáte oprávnění k provedení této operace."
        redirect_to(galleries_path)
      end
    end
end

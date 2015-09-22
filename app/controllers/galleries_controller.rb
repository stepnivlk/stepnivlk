class GalleriesController < ApplicationController
  before_action :find_gallery, only: [:show, :edit, :update, :destroy]

  def index
    @galleries = Gallery.all
  end

  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = Gallery.new(gallery_params)

    if @gallery.save
      if params[:images]
        params[:images].each { |image| @gallery.images.create(file: image)}
      end
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
      params.require(:gallery).permit(:name, :description, :images)
    end

    def find_gallery
    @gallery = Gallery.find(params[:id])
  end
end

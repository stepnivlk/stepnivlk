class ImagesController < ApplicationController
  before_action :find_image, only: [:show, :edit, :update, :destroy]

  def index
    @images = Image.all
  end

  #delete this
  def new
    @image = Image.new
  end

  def create
    @image = Image.new image_params
    if @image.save
      redirect_to gallery_image_path(@image.gallery_id, @image), notice: "Your image was successfully saved"
    else
      render 'new', notice: "Unable to save your image"
    end
  end

  def show
      @gallery_name = Gallery.find(@image.gallery_id).name

  end

  def edit
  end

  def update
    if @image.update image_params
      redirect_to gallery_image_path(@image.gallery_id, @image), notice: "Your image was cuccessfully saved"
    else
      render 'edit'
    end
  end

  def destroy
    @image.destroy
    #fix this to gallery path
    redirect_to gallery_path(@image.gallery_id)
  end

  private

    def image_params
      params.require(:image).permit(:name, :file, :tag_list)
    end

    def find_image
      @image = Image.find(params[:id])
    end

end

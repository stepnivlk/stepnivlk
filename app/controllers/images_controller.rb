class ImagesController < ApplicationController
  skip_before_action :logged_in_user, only: :show
  before_action :find_image, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  #delete this
  # def new
  #   @image = Image.new
  # end

  # def create
  #   @image = Image.new image_params
  #   if @image.save
  #     redirect_to gallery_image_path(@image.gallery_id, @image), notice: "Your image was successfully saved"
  #   else
  #     render 'new', notice: "Unable to save your image"
  #   end
  # end

  def show
  end

  def edit
  end

  def update
    if @image.update image_params
      flash[:success] = "Image succesfully updated."
      redirect_to gallery_image_path(@image.gallery, @image)
    else
      render 'edit'
    end
  end

  # fix if not destroyed
  def destroy
    @image.destroy
    flash[:danger] = "Image deleted."
    redirect_to gallery_path(@image.gallery)
  end

  private

    def image_params
      params.require(:image).permit(:name, :file, :tag_list)
    end

    def find_image
      @image = Image.find(params[:id])
    end

    def correct_user
      unless @image.gallery.user == current_user || current_user.admin
        flash[:danger] = "You don't have rights to perform this operation."
        redirect_to(gallery_image_path(@image.gallery, @image))
      end
    end

end

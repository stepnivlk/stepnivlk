class ImagesController < ApplicationController
  skip_before_action :logged_in_user, only: :show
  before_action :find_image, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  respond_to :html, :js

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @image.update image_params
        format.html { redirect_to(gallery_image_path(@image.gallery, @image)) }
        format.js
      else
        flash.now[:warning] = "Váš obrázek nebyl uložen, zkuste to znovu."
        render 'edit'
      end
    end
  end

  def destroy
    @image.destroy
    flash[:danger] = "Obrázek byl smazán."
    next_item = Image.where("id > ?", params[:id].to_i).first
    if next_item
      redirect_back_or action: 'show', id: next_item.id
    else
      redirect_back_or gallery_image_path(@image.gallery, @image)
    end
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
        flash[:danger] = "Nemáte oprávnění k provedení této operace."
        redirect_to(gallery_image_path(@image.gallery, @image))
      end
    end

end

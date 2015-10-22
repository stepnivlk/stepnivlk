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
        flash.now[:danger] = "Váš obrázek nebyl uložen, zkuste to znovu."
        render 'edit'
      end
    end
  end

  def destroy
    if @image.destroy
      respond_to do |format|
        format.js
        format.html do 
          flash[:danger] = "Váš obrázek byl smazán."
          if next_item = Image.where("id > ?", @image.id).first
            redirect_back_or(action: 'show', id: next_item.id)
          else
            redirect_back_or(gallery_path(@image.gallery, @image)) 
          end
        end
      end
    else
      flash[:danger] = "Chyba! Váš obrázek nebyl smazán."
      redirect_back_or(gallery_path(@image.gallery, @image)) 
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

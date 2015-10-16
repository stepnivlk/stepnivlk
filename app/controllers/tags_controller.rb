class TagsController < ApplicationController
  skip_before_action :logged_in_user, only: [:index, :show]
  before_action :find_tag, only: [:show, :destroy]
  before_action :correct_user, only: [:index, :destroy]

  def index
    @tags = Tag.all
  end

  def show
    @stream = @tag.posts + @tag.images
  end

  def destroy
    @tag.destroy

    flash.notice = "Tag '#{@tag.name}' Deleted"

    redirect_to tags_path
  end

  private

    def tag_params
      params.require(:tag).permit(:id)
    end

    def find_tag
      @tag = Tag.find(params[:id])
    end

    def correct_user
      unless current_user.admin
        flash[:danger] = "Nemáte oprávnění k provedení této operace."
        redirect_to(:back)
      end
    end
end

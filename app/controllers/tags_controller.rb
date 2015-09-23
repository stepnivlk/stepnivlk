class TagsController < ApplicationController
  before_action :find_tag, only: [:show, :destroy]

  def index
    @tags = Tag.all
  end

  def show
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
end

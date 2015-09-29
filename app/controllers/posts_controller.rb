class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.order("created_at DESC").all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Your post was successfully saved"
      redirect_to @post
    else
      flash[:warning] = "Unable to save your post"
      render 'new'
    end
  end

  def show
    @comment = @post.comments.build
    @comments = @post.comments
  end

  def edit
  end

  def update
    if @post.update post_params
      flash[:success] = "Your post was successfully saved"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

    def post_params
      params.require(:post).permit(:title, :content, :tag_list)
    end

    def find_post
    @post = Post.find(params[:id])
  end
end

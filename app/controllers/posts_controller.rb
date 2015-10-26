class PostsController < ApplicationController
  skip_before_action :logged_in_user, only: [:index, :show]
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @posts = scoped_index(Post)
  end

  def new
    @post = Post.new
    @gallery = Gallery.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Váš příspěvek byl úspěšně uložen."
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    # Only correct user can see non-public post.
    unless @post.public
      correct_user
    end
    # Used for new comment form.
    @comment = @post.comments.build
    # All comments associated to post with pagination.
    @comments = @post.comments.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def edit
    @gallery = Gallery.new
  end

  def update
    if @post.update post_params
      flash[:success] = "Váš příspěvek byl úspěšně aktualizován."
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
      params.require(:post).permit(:title, :content, :tag_list, :public)
    end

    def find_post
      @post = Post.find(params[:id])
    end

    # Checks if current user is author, or admin, if not redirects.
    def correct_user
      unless @post.user == current_user || logged_in_admin?
        flash[:danger] = "Nemáte oprávnění k provedení této operace."
        redirect_to posts_path 
      end
    end
end

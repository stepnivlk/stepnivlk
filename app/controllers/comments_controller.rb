class CommentsController < ApplicationController
  skip_before_action :logged_in_user, only: :create
  before_action :correct_user, only: :destroy
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)

    # Recaptcha test for real user.
    if verify_recaptcha
      if @comment.save
        flash[:success] = "Komentář přidán."
        redirect_to post_path(@post)
      else
        @comments = @post.comments
        flash.now[:warning] = "Komentář nebylo možné uložit"
        render "posts/show"
      end
    else
      flash.delete(:recaptcha_error)
      flash[:warning] = "Prosím zaškrtněte políčko I'm not a robot."
      redirect_to post_path(@comment.post)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:danger] = "Komentář odstraněn!"
    redirect_to post_path(@comment.post)
  end  


private
  def comment_params
    params.require(:comment).permit(:title, :author, :body)
  end

  def correct_user
    unless current_user.admin
      flash[:danger] = "Nemáte oprávnění k provedení této operace."
      redirect_to post_path(@post)
    end
  end
end

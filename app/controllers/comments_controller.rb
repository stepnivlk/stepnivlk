class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)

    if verify_recaptcha
      if @comment.save
        flash[:success] = "Komentar pridan!"
        redirect_to post_path(@post)
      else
        @comments = @post.comments
        flash.now[:warning] = "Unable to save your comment"
        render "posts/show"
      end
    else
      flash.delete(:recaptcha_error)
      flash[:warning] = "Prosim zaskrtnete policko I'm not a robot."
      redirect_to post_path(@comment.post)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:danger] = "Komentar odstranen!"
    redirect_to post_path(@comment.post)
  end  


private
  def comment_params
    params.require(:comment).permit(:title, :author, :body)
  end
end

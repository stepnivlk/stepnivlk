class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]

    if verify_recaptcha
      @comment.save
      redirect_to post_path(@comment.post)
    else
      flash.delete(:recaptcha_error)
      flash[:danger] = "Prosim zaskrtnete policko I'm not a robot."
      redirect_to post_path(@comment.post)
    end

  end


private
  def comment_params
    params.require(:comment).permit(:title, :author, :body)
  end
end

class HomeController < ApplicationController
  skip_before_action :logged_in_user

  def index
    # content stream for recent activity.
    @streams = content_sorted(8)
    # user used for infoboxes
    @user = User.find_by(email: "tomas@stepnivlk.net")
    @simple_user_infos = @user.simple_user_infos
    @skills = @user.skills.order("in_love_index DESC")
    @educations = @user.educations
    @experiences = @user.experiences
    # New mail object, used in messagebox for sending mails.
    @message = Message.new
  end

  # stream, full mix of all content.
  def stream
    @streams = content_sorted(false)
  end

  private

    # Returns sorted mix of n Posts and Galleries.
    #
    # paginate - Redirect to scoped_index method.
    # count    - No. of returned objects, nill=all.
    def content_sorted(paginate = true, count=nil)
      sorted = (scoped_index(Post, paginate) + scoped_index(Gallery, paginate)).sort_by(&:created_at).reverse
      return  sorted.last(count) if count
      sorted
    end
end
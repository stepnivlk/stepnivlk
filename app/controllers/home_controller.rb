class HomeController < ApplicationController
  skip_before_action :logged_in_user

  def index
    @streams = content_sorted(8)
    @user = User.find(1)
    @simple_user_infos = @user.simple_user_infos
    @skills = @user.skills.order("in_love_index DESC")
    @educations = @user.educations
    @experiences = @user.experiences
    @message = Message.new
  end

  def stream
    @streams = content_sorted()
  end

  private
    def content_sorted(count=nil)
      sorted = (Post.all + Gallery.all).sort_by(&:created_at).reverse
      return  sorted.last(count) if count 
      sorted
    end
end

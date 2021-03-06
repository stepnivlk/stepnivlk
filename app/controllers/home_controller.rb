require 'will_paginate/array'

class HomeController < ApplicationController
  skip_before_action :logged_in_user

  def index
    # content stream for recent activity.
    @streams = (Post.where(public: true).last(4) + Gallery.where(public: true).last(4)).sort_by(&:created_at).reverse
    # user used for infoboxes
    @user = User.find(1)
    @simple_user_infos = @user.simple_user_infos
    @skills = @user.skills.order("in_love_index DESC")
    @educations = @user.educations
    @experiences = @user.experiences
    # New mail object, used in messagebox for sending mails.
    @message = Message.new
  end

  # stream, full mix of all content.
  def stream
    @streams = content_sorted.paginate(page: params[:page], per_page: 25)
  end

  private

    # Returns sorted mix of n Posts and Galleries.
    #
    # count - No. of returned objects, nill=all.
    def content_sorted(count=nil, paginate=true)
      content = (scoped_index(Post, paginate) + scoped_index(Gallery, paginate))
      sorted = content.sort_by(&:created_at).reverse
      return  sorted.last(count) if count
      sorted
    end
end
class HomeController < ApplicationController
  def index
    @posts = Post.all.order("created_at desc")
    @stream = posts_and_galleries_sorted.reverse
  end

  private
    def posts_and_galleries_sorted
      sorted = Post.last(4) << Gallery.last(4)
      sorted.flatten!.sort_by &:created_at
    end
end

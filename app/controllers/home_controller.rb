class HomeController < ApplicationController
  def index
    @posts = Post.all.order("created_at desc")
    @stream = posts_and_galleries_sorted
  end

  private
    def posts_and_galleries_sorted
      sorted = Post.all << Gallery.all
      sorted.flatten!.sort_by(&:created_at).last(8).reverse
    end
end

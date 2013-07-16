class BlogController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by_url(params[:url])
  end

end

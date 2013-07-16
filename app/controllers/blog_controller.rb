class BlogController < ApplicationController

  def index
    @posts = Post.all
    @admin = admin_signed_in?
  end

  def show
    @post  = Post.find_by_url(params[:url])
    @admin = admin_signed_in?
  end

end

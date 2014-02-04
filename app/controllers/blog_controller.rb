class BlogController < ApplicationController

  def index
    @posts = Post.order("created_at DESC").page(params[:page]).per(3)
    @admin = admin_signed_in?
  end

  def show
    @post  = Post.find_by(url: params[:url])
    @admin = admin_signed_in?
  end

end

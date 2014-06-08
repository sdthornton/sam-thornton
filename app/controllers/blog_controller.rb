class BlogController < ApplicationController

  def index
    @posts = Post.order("created_at DESC").page(params[:page]).per(3)
  end

  def show
    if Post.find_by(url: params[:url])
      @post = Post.find_by(url: params[:url])
    else
      @post = Slug.find_by!(url: params[:url]).post.url
      redirect_to show_post_path(@post)
    end
  end

end

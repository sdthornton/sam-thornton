class PostsController < ApplicationController

  before_filter :authenticate_admin!
  force_ssl if: :ssl_configured?

  def faith
    @posts = Post.where(primary_category: 'faith')
    render json: @posts
  end

  def tech
    @posts = Post.where(primary_category: 'tech')
    render json: @posts
  end

  def show
    set_post
    render json: @post
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    set_post
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    set_post
    @post.destroy
  end

private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :url, :snippet)
  end

end

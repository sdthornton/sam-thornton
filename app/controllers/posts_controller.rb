class PostsController < ApplicationController

  before_filter :authenticate_admin!
  force_ssl if: :ssl_configured?

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
      flash[:notice] = 'Post successfully created'
    else
      render 'new'
      flash[:error] = 'Post was not saved. Errors are present.'
    end
  end

  def show
    @post = Post.find(params[:id])
    redirect_to show_post_path(@post.url)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to show_post_path(@post.url)
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to blog_path
  end

private

    def post_params
      params.require(:post).permit(:title, :content, :url, :snippet)
    end

    def ssl_configured?
      !Rails.env.development?
    end

end

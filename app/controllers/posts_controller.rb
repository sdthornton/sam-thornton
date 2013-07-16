class PostsController < ApplicationController

  before_filter :authenticate_admin!

  def new
  end

  def create
    @post = Post.new(post_params)

    @post.url = @post.title.parameterize.underscore.to_s
    @post.save
    redirect_to show_post_path(@post.url)
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(params[:post].permit(:title, :text, :url))
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
      params.require(:post).permit(:title, :text, :url)
    end

end

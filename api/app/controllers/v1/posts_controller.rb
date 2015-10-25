module V1
  class PostsController < ApplicationController

    skip_before_action :authenticate_admin_from_token!, only: [:faith, :tech, :show]
    before_action :set_post, only: [:show, :update, :destroy]

    def faith
      @posts = Post.where(category: 'faith')
      render json: @posts, each_serializer: PostsSerializer
    end

    def tech
      @posts = Post.where(category: 'tech')
      render json: @posts, each_serializer: PostsSerializer
    end

    def show
      render json: @post, serializer: PostSerializer
    end

    def create
      @post = Post.new(post_params)

      if @post.save
        render json: @post, status: :created, serializer: PostSerializer
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    def update
      if @post.update(post_params)
        render json: @post, serializer: PostSerializer
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @post.destroy
    end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :category, :url, :snippet)
    end

  end
end

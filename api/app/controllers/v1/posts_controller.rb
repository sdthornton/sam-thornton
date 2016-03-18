module V1
  class PostsController < ApplicationController

    skip_before_action :authenticate_admin_from_token!, only: [:faith, :tech, :show]
    before_action :set_post, only: [:edit, :update, :destroy]

    def faith
      @posts = Post.where(category: 'faith').order('created_at DESC')
      render json: @posts, each_serializer: PostsSerializer
    end

    def tech
      @posts = Post.where(category: 'tech').order('created_at DESC')
      render json: @posts, each_serializer: PostsSerializer
    end

    def edit
      render json: @post, serializer: PostSerializer
    end

    def show
      if (params[:ref].to_i.to_s == params[:ref])
        @post = Post.find(params[:ref])
      else
        @post = Post.find_by(url: params[:ref])
      end

      render json: @post, serializer: PostSerializer
    end

    def create
      @post = Post.new(post_params)

      if @post.save
        render json: @post, status: :created, serializer: PostSerializer
      else
        render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
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
      params
        .require(:post)
        .permit(:title, :body, :category, :url, :snippet, :tag_list)
    end

  end
end

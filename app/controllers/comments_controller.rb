class CommentsController < ApplicationController

  def create
    @post    = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:commenter, :body))
    redirect_to show_post_path(@post.url)
  end

end

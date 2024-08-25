class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[create update destroy]
  before_action :set_comment, only: %i[update destroy]
  before_action :authorize_user!, only: %i[update destroy]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
      @comment.destroy
      render json: { message: "Comment deleted" }, status: :ok
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_user!
    render json: { error: 'Not Authorized' }, status: :forbidden unless @comment.user_id == current_user.id
  end
end

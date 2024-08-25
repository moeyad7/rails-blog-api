class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show update destroy]
  before_action :authorize_user!, only: %i[update destroy]

  def index
    @posts = Post.includes(:comments).all
    render json: @posts, include: :comments
  end

  def show
    render json: @post.as_json(include: :comments)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      render json: @post.as_json(include: :comments), status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: @post.as_json(include: :comments)
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    render json: { message: "Post deleted" }, status: :ok
  end

  private

  def set_post
    @post = Post.includes(:comments).find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, tags: [])
  end

  def authorize_user!
    Rails.logger.debug(@post.author_id)
    render json: { error: "Not Authorized" }, status: :forbidden unless @post.author_id == current_user.id
  end
end

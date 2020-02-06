class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)
    @post.user_id = current_user.id
  	@post.save
  	redirect_to post_path(@post)
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user_id != current_user.id
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
        @post.update(post_params)
        redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
        @post.destroy
        redirect_to posts_path
    else
      @posts = Post.all
      render "index"
    end
  end

  private
  	def post_params
  		params.require(:post).permit(:user_id, :title, :body, :image)
  	end
end

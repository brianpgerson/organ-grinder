class PostsController < ApplicationController
  before_action :ensure_logged_in

  def index
    @posts = Post.where(user_id: current_user.id)
  end

  def show
    @post = Post.find_by_id(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "Thanks for posting, brah!"
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      @post = Post.new(post_params)
      render :new
    end
  end

  def new
    @post = Post.new
  end

  def update
    @post = Post.find_by_id(params[:id])
    if @post.update(post_params)
      flash[:notice] = "Thanks for updating that post, cool guy!"
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      @post = Post.find_by_id(params[:id])
      @post.title, @post.body = post_params[:title], post_params[:body]
      render :edit
    end
  end

  def edit
    @post = Post.find_by_id(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def ensure_logged_in
    if current_user.nil?
      flash[:notice] = "Woah, there, hombre - you gotta sign in first!"
      redirect_to new_session_url
    end
  end
end

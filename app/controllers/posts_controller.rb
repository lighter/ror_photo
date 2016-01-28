class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    if @post = Post.create(post_params)
      flash[:success] = "Your post success"
      redirect_to posts_path
    else
      flash.now[:alert] = "Your post failed"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post updated"
      redirect_to posts_path
    else
      flash.now[:alert] = "Update failed"
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end


  private

    def post_params
      params.require(:post).permit(:image, :caption)
    end

    def set_post
      @post = Post.find(params[:id])
    end
end

class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  before_action :owned_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    # @post = Post.new
    @post = current_user.posts.build
  end

  def create
    # if @post = Post.create(post_params)
    #   flash[:success] = "Your post success"
    #   redirect_to posts_path
    # else
    #   flash.now[:alert] = "Your post failed"
    #   render :new
    # end

    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "successful"
      redirect_to posts_path
    else
      flash[:alert] = "failed"
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

    def owned_post
      unless current_user == @post.user
        flash[:alert] = "That post doesn't belong to you"
        redirect_to root_path
      end
    end
end

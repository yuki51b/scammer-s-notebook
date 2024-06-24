class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update]
  before_action :set_scams, only: %i[new create show edit update]

  def index
    @posts = Post.includes(:user, :scam)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
      if @post.save
        redirect_to posts_path, notice: '投稿できました'
      else
        flash.now[:alert] = "投稿に失敗しました"
        render :new
      end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: '更新しました'
    else
      flash.now[:alert] = "編集に失敗しました"
      render :show
    end
  end


private

  def post_params
    params.require(:post).permit(:title, :body, :scam_id)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def set_scams
    @scams = Scam.all
  end
end

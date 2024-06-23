class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user, :scam)
  end

  def new
    @post = Post.new
    @scams = Scam.all
  end

  def create
    @post = current_user.posts.new(post_params)
      if @post.save
        redirect_to posts_path, notice: '投稿できました'
      else
        flash.now[:alert] = "投稿に失敗しました"
        @scams = Scam.all
        render :new
      end
  end

private

  def post_params
    params.require(:post).permit(:title, :body, :scam_id)
  end
end

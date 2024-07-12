class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update]
  before_action :set_scams, only: %i[new show edit update]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user)
    @search_target = 'post'
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
      if @post.save
        redirect_to posts_path, notice: '投稿に成功したぞ！'
      else
        flash.now[:alert] = "投稿に失敗しました"
        render :new
      end
  end

  def show
    @post = Post.find(params[:id])
    @post_body = @post.body.split("\n")
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

  def autocomplete
    term = params[:q]
    @posts = Post.where('users_scam_name LIKE ?', "%#{term}%")
    render partial: 'posts/autocomplete', locals: { posts: @posts }
  end



private

  def post_params
    params.require(:post).permit(:title, :body, :users_scam_name)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def set_scams
    @scams = Scam.all
  end
end

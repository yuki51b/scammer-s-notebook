class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy]
  before_action :set_scams, only: %i[new show edit update destroy]
  skip_before_action :require_login, only: %i[index show]
  helper_method :prepare_meta_tags

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page]).per(12)
    @search_target = 'post'
  end

  def show
    @post = Post.find(params[:id])
    prepare_meta_tags(@post)
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_path, notice: '投稿に成功したぞ！'
    else
      flash.now[:alert] = '投稿に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: '更新しました'
    else
      flash.now[:alert] = '編集に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, notice: '削除しました', status: :see_other
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

  def prepare_meta_tags(post)
    image_url = "#{request.base_url}/images/ogp.png?text=#{CGI.escape(post.title)}"
    set_meta_tags og: {
                    site_name: '詐欺師の手帳',
                    title: post.title,
                    description: 'ユーザーによる詐欺被害の投稿です',
                    type: 'website',
                    url: request.original_url,
                    image: image_url,
                    locale: 'ja-JP'
                  },
                  twitter: {
                    card: 'summary_large_image',
                    site: '@https://x.com/yukimura877',
                    image: image_url
                  }
  end
end

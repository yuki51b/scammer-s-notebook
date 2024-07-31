class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update]
  before_action :set_scams, only: %i[new show edit update]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user).order(created_at: :desc)
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
        redirect_to new_post_path, alert: '投稿に失敗しました'
      end
  end

  def show
    @post = Post.find(params[:id])
    prepare_meta_tags(@post)
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
      site: '@your_twitter_account',
      image: image_url
    }
  end
end

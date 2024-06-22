class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user)
  end
end

class Admin::BaseController < ApplicationController
  before_action :check_admin
  layout 'admin/layouts/application'

  private

  def not_authenticated
    redirect_to admin_login_path, warning: 'ログインしてください'
  end

  # ↓管理者権限を持っているか確認する
  # current_user.admin?のadmin?がuser.rbモデルに定義したメソッド
  def check_admin
    redirect_to root_path, error: "権限がありません" unless current_user.admin?
  end
end

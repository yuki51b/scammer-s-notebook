class Admin::UserSessionsController < Admin::BaseController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :check_admin, only: %i[new create]

  # 宣言しないとrailsはデフォルトではview/layouts/applicationにいく
  # ↓ログインページ用のレイアウトを用意するので宣言
  layout 'layouts/admin_login'

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to admin_root_path, notice: "管理画面にログインしました"
    else
      flash.now[:alert] = "ログインに失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to admin_login_path, notice: "ログアウトしました", status: :see_other
  end
end

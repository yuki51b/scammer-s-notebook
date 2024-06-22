class UserSessionsController < ApplicationController
    skip_before_action :require_login, only: [:create, :new]

    def new; end

    def create
        @user = login(params[:email], params[:password])

        if @user
            redirect_to root_path, notice: "ログインしました"
        else
            flash.now[:alert] = "ログインに失敗しました"
            render :new
        end
    end

    def destroy
        logout
        redirect_to root_path, notice: "ログアウトしました", status: :see_other
    end
end

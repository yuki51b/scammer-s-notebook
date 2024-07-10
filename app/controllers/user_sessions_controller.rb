class UserSessionsController < ApplicationController
    skip_before_action :require_login, only: [:create, :new]

    def new; end

    def create
        @user = login(params[:email], params[:password])

        if @user
            redirect_to root_path, notice: "僕の手帳を楽しんでくれ！"
        else
            flash.now[:alert] = "ログインに失敗しました"
            render :new
        end
    end

    def destroy
        logout
        redirect_to root_path, notice: "またな！", status: :see_other
    end
end

class UsersController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to root_path, notice: "登録できました"
        else
            flash.now[:alert] = "登録できませんでした"
            render :new, status: :unprocessable_entity
        end
    end

private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
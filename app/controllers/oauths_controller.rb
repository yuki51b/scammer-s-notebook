class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if (@user = login_from(provider))
      redirect_to root_path, notice: '僕の手帳を楽しんでくれ!'
    else
      begin
        @user = create_from(provider)
        # NOTE: this is the place to add '@user.activate!' if you are using user_activation submodule

        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_to root_path, notice: '僕の手帳を楽しんでくれ!'
      rescue StandardError
        redirect_to root_path, alert: "Failed to login from #{provider.titleize}!"
      end
    end
  end
end

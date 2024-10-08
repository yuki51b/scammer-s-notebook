# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def not_authenticated
    redirect_to login_path, alert: 'ここから先はログインをしてくれよな！'
  end
end

# frozen_string_literal: true

class TopsController < ApplicationController
  skip_before_action :require_login, only: [ :index, :privacy_policy, :terms]


  def index; end

  def privacy_policy; end

  def terms; end
end

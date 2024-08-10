# frozen_string_literal: true

class TopsController < ApplicationController
  skip_before_action :require_login, only: [ :index, :privacy_policy, :terms, :list_of_support]


  def index; end

  def privacy_policy; end

  def terms; end

  def line_notify; end

  def list_of_support; end
end

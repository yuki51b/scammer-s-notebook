# frozen_string_literal: true

class TopsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  
  def index; end
end

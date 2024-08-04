class Admin::ScamsController < Admin::BaseController

  def index
    @scams = Scam.all
  end
end

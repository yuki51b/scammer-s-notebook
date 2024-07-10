class ScamsController < ApplicationController

    def index
        @scams = Scam.all
    end

    def show
        @scam = Scam.find(params[:id])
        @scam_strategy = @scam.scam_strategy.split("\n")
    end
end

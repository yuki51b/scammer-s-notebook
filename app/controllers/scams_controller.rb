class ScamsController < ApplicationController

    def index
        @scams = Scam.all
    end

    def show
        @scam = Scam.find(params[:id])
    end
end

class ScamsController < ApplicationController

    def show
        @scam = Scam.find(params[:id])
    end
end

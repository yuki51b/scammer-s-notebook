class ScamsController < ApplicationController

    def index
        @scams = Scam.all
    end

    def show
        @scam = Scam.find(params[:id])
        @scam_strategy = @scam.scam_strategy.split("\n")
    end

    # def autocomplete
    #     term = params[:q]
    #     @scams = Scam.where('name LIKE ?', "%#{term}%")
    #     render partial: 'scams/autocomplete', locals: { scams: @scams }
    # end
end

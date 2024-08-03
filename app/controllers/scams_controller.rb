class ScamsController < ApplicationController

    def index
        @q = Scam.ransack(params[:q])
        @scams = @q.result(distinct: true).order("name")
        @search_target = 'scam'
    end

    def show
        @scam = Scam.find(params[:id])
        @scam_strategy = @scam.scam_strategy.split("\n")
    end

    def autocomplete
        term = params[:q]
        @scams = Scam.where('name LIKE ?', "%#{term}%")
        render partial: 'scams/autocomplete', locals: { scams: @scams }
    end
end

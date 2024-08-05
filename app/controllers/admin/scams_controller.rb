class Admin::ScamsController < Admin::BaseController
  before_action :set_scam, only: %i[show edit update destroy]

  def index
    @scams = Scam.all.order("name")
  end

  def new
    @scam = Scam.new
  end

  def create
    @scam = Scam.new(scam_params)

    if @scam.save
      redirect_to admin_scams_path, notice: "詐欺情報を作成しました"
    else
      redirect_to new_admin_scam_path, alert: "作成に失敗しました"
    end
  end

  def show
    @scam_strategy = @scam.scam_strategy.split("\n")
  end

  def edit; end

  def update
    if @scam.update(scam_params)
      redirect_to admin_scam_path(@scam), notice: "編集に成功しました"
    else
      render :edit, alert: "編集に失敗しました"
    end
  end

  def destroy
    @scam.destroy!
    redirect_to admin_scams_path, notice: "削除しました", status: :see_other
  end

private

def scam_params
  params.require(:scam).permit(:name, :content, :point_1, :point_2, :point_3, :scam_strategy)
end

def set_scam
  @scam = Scam.find(params[:id])
end

end

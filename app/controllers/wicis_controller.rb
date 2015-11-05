class WicisController < ApplicationController
  before_action :find_wiki, only: [:show, :edit, :update, :destroy]

  

  def index
    @wicis = policy_scope(Wici)
    authorize @wicis
  end

  def show
    #find_wiki
    authorize @wici
  end

  def new
    @wici = Wici.new
    authorize @wici
  end

  def edit
    #find_wiki
    authorize @wici
  end

  def create
    @wici = current_user.wicis.build(wici_params)
    authorize @wici
    if @wici.save
      flash[:notice] = "Wici was saved"
      redirect_to @wici
    else
      flash[:error] = "There was a problem saving your Wici"
      render :new
    end
  end

  def update
    #find_wiki
    authorize @wici
    if @wici.update_attributes(wici_params)
      flash[:notice] = "Wici was saved"
      redirect_to @wici
    else
      flash[:error] = "There was a problem updating your Wici"
      render :edit
    end
  end

  def destroy
    #find_wiki
    authorize @wici
    if @wici.destroy
      flash[:notice] = "Wici was deleted"
      redirect_to wicis_path
    else
      flash[:error] = "There was a problem deleting your wici"
      render :show
    end
  end 

  private

  def find_wiki
    @wici = Wici.find(params[:id])
  end

  def wici_params
    params.require(:wici).permit(:title, :body, :private)
  end

end

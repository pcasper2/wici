class WicisController < ApplicationController
  before_action :find_wiki, only: [:show, :edit, :update, :destroy]
  def index
    @wicis = Wici.all
  end

  def show
  end

  def new
    @wici = Wici.new
  end

  def edit
  end

  def create
    @wici = current_user.wicis.build(wici_params)
    if @wici.save
      flash[:notice] = "Wici was saved"
      redirect_to @wici
    else
      flash[:error] = "There was a problem saving your Wici"
      render :new
    end
  end

  def update
    if @wici.update_attributes(wici_params)
      flash[:notice] = "Wici was saved"
      redirect_to @wici
    else
      flash[:error] = "There was a problem updating your Wici"
      render :edit
    end
  end

  def destroy
    if @wici.destroy
      flash[:notice] = "Wici was deleted"
      redirect_to welcome_index_path
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

class NationalitiesController < ApplicationController
  def index
    @nationalities = Nationality.all
  end

  def new
    @nationality = Nationality.new
  end

  def create
    @nationality = Nationality.new(nationality_params)
    if @nationality.save
      flash[:success]='Гражданство добавлен'
      redirect_to action: 'index'
    else
      flash[:error]='Гражданство не добавлен'
      render 'new'
    end
  end

  def edit
    @nationality = Nationality.find(params[:id])
  end

  def update
    @nationality = Nationality.find(params[:id])
    if @nationality.update_attributes(nationality_params)
      flash[:success]='Гражданство добавлен'
      redirect_to action: 'index'
    else
      flash[:error]='Гражданство не добавлен'
      render 'new'
    end
  end

  def destroy
    @nationality = Nationality.find(params[:id])
    if @nationality.destroy
      flash[:success]='Гражданство удален'
    else
      flash[:success]='Гражданство не удален'
    end 
    redirect_to action: 'index'
  end

  def nationality_params
    params.require(:nationality).permit(:name)
  end
end

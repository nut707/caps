class LanguagesController < ApplicationController
  def index
    @languages = Language.all
  end

  def new
    @language = Language.new
  end

  def create
    @language = Language.new(language_params)
    if @language.save
      flash[:success]='Язык добавлен'
      redirect_to action: 'index'
    else
      flash[:error]='Язык не добавлен'
      render 'new'
    end
  end

  def edit
    @language = Language.find(params[:id])
  end

  def update
    @language = Language.find(params[:id])
    if @language.update_attributes(language_params)
      flash[:success]='Язык добавлен'
      redirect_to action: 'index'
    else
      flash[:error]='Язык не добавлен'
      render 'new'
    end
  end

  def destroy
    @language = Language.find(params[:id])
    if @language.destroy
      flash[:success]='Язык удален'
    else
      flash[:success]='Язык не удален'
    end 
    redirect_to action: 'index'
  end

  def language_params
    params.require(:language).permit(:name)
  end
end

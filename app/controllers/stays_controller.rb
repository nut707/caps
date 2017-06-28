class StaysController < ApplicationController
  load_and_authorize_resource

  def new
    @profile = Profile.find(params[:profile_id])
    @stay = @profile.stays.new
    session[:return_to] ||= request.referer+'#participants'
  end

  def create
    @profile = Profile.find(params[:profile_id])
    @stay = @profile.stays.new(stay_params)
    if @profile.save
      flash[:success]='Время пребывания добавлено'
      redirect_to session.delete(:return_to)
    else
      flash[:error]='Время пребывания не добавлено'
      render 'new'
    end
  end

  def destroy
    if Stay.find(params[:id]).destroy
      flash[:success]='Время пребывания удалено'
    else
      flash[:error]='Время пребывания не удалено'
    end 
    redirect_to request.referer+'#participants'
  end

  private
  def stay_params
    params.require(:stay).permit!
  end
end

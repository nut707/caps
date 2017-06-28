class ProfilesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
    
  def index
    @profiles = Profile.all.includes(:user, :stays)
  end

  def new
    @profile = Profile.new
  end

  def create
    @user= current_user
    @profile = @user.build_profile(profile_params)
    @profile.save
    redirect_to root_path
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def edit
    @profile=Profile.find(params[:id])
    @publications=@profile.publications
  end

  def update
    @profile=Profile.find(params[:id])
    if @profile.update_attributes(profile_params)
      render 'show'
    else
      render 'edit'
    end
  end

  def destroy
    @profile = Profile.find(params[:id])
    if @profile.destroy
      redirect_to :back
    else
      flash[:error] = @profile.errors.full_messages.to_sentence
      redirect_to :back
    end
  end

  private
  def profile_params
    params.require(:profile).permit!
  end

end

class ActivityDirectionsController < ApplicationController
  load_and_authorize_resource

  def index
    @directions = ActivityDirection.all
  end

  def new
    @direction = ActivityDirection.new
  end

  def create
    @direction = ActivityDirection.create(resource_params)
    @direction.save
    redirect_to action: "index"
  end

  def edit
    @direction=ActivityDirection.find(params[:id])
  end

  def update
    @direction=ActivityDirection.find(params[:id])
    if @direction.update_attributes(resource_params)
      redirect_to action: "index"
    else
      render 'edit'
    end
  end

  def destroy
    @direction = ActivityDirection.find(params[:id])
    if @direction.destroy
      flash[:success]='Объект удален'
      redirect_to action: "index"
    else
      flash[:error] = @direction.errors.full_messages.to_sentence
      redirect_to :back
    end
  end

  private
  def resource_params
    params.require(:activity_direction).permit!
  end
end

class RatesController < ApplicationController
  load_and_authorize_resource

  def index
    @Rate = Rate.all
  end

  # def new
  #   @rate = Rate.new
  # end

  # def create
  #   @rate = Rate.create(resource_params)
  #   @rate.save
  #   redirect_to action: "index"
  # end

  def edit
    @rate=Rate.find(params[:id])
  end

  def update
    @rate=Rate.find(params[:id])
    if @rate.update_attributes(resource_params)
      redirect_to action: "index"
    else
      render 'edit'
    end
  end

  # def destroy
  #   @rate = Rate.find(params[:id])
  #   if @rate.destroy
  #     flash[:success]='Объект удален'
  #     redirect_to action: "index"
  #   else
  #     flash[:error] = @rate.errors.full_messages.to_sentence
  #     redirect_to :back
  #   end
  # end

  private
  def resource_params
    params.require(:rate).permit!
  end
end

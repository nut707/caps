class ScienceBranchesController < ApplicationController
  load_and_authorize_resource

  def index
    @branches = ScienceBranch.all
  end

  def new
    @branch = ScienceBranch.new
  end

  def create
    @branch = ScienceBranch.create(resource_params)
    @branch.save
    redirect_to action: "index"
  end

  def edit
    @branch=ScienceBranch.find(params[:id])
  end

  def update
    @branch=ScienceBranch.find(params[:id])
    if @branch.update_attributes(resource_params)
      redirect_to action: "index"
    else
      render 'edit'
    end
  end

  def destroy
    @branch = ScienceBranch.find(params[:id])
    if @branch.destroy
      flash[:success]='Объект удален'
      redirect_to action: "index"
    else
      flash[:error] = @branch.errors.full_messages.to_sentence
      redirect_to :back
    end
  end

  private
  def resource_params
    params.require(:science_branch).permit!
  end
end

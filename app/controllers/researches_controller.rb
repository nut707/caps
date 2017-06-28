class ResearchesController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :research, through: :project

  def new
    @project = Project.find(params[:project_id])
    @research = Research.new
  end

  def create
    @project = Project.find(params[:project_id])
    @research = @project.researches.new(research_params)
    if @research.save
      flash[:success] = 'Исследование добавлено'
      redirect_to project_path(@project, anchor: 'researches')
    else
      flash[:error] = 'Исследование не добавлено'
      render 'new'
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @research = Research.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @research = Research.find(params[:id])
    if @research.update_attributes(research_params)
      flash[:success] = 'Исследование обновлено'
      redirect_to project_path(@project, anchor: 'researches')
    else
      flash[:error] = 'Исследование не обновлено'
      render 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    if Research.find(params[:id]).destroy
      flash[:success] = 'Исследование удалено'
    else
      flash[:success] = 'Исследование не удалено'
    end    
    redirect_to project_path(@project, anchor: 'researches')
  end

  def show
    @research = Research.find(params[:id])
  end

  private

  def research_params
    params.require(:research).permit!
  end
end

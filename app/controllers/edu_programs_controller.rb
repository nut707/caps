class EduProgramsController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :edu_program, through: :project

  def new
    @project = Project.find(params[:project_id])
    @edu_program=EduProgram.new
  end

  def create
    @project = Project.find(params[:project_id])
    @edu_program=@project.edu_programs.new(edu_program_params)
    if @edu_program.save
      flash[:success]='Образовательная программа добавлено'
      redirect_to project_path(@project, anchor: 'edu_programs')
    else
      flash[:error]='Образовательная программа не добавлено'
      render 'new'
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @edu_program=EduProgram.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @edu_program=EduProgram.find(params[:id])
    if @edu_program.update_attributes(edu_program_params)
      flash[:success]='Образовательная программа обновлено'
      redirect_to project_path(@project, anchor: 'edu_programs')
    else
      flash[:error]='Образовательная программа не обновлено'
      render 'edit'
    end
  end
 
  def destroy
    @project = Project.find(params[:project_id])
    if EduProgram.find(params[:id]).destroy
      flash[:success]='Образовательная программа удалено'
    else
      flash[:success]='Образовательная программа не удалено'
    end 
    redirect_to project_path(@project, anchor: 'edu_programs')
  end

  def show
    @edu_program=EduProgram.find(params[:id])
  end

  private
  def edu_program_params
    params.require(:edu_program).permit!
  end
end

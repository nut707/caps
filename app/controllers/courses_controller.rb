class CoursesController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :course, through: :project

  def index
    @courses = Course.all
  end

  def new
    @project = Project.find(params[:project_id])
    if params[:edu_program_id].present?
      @edu_program = EduProgram.find(params[:edu_program_id]) 
      @course = @edu_program.courses.new
    else
      @course = @project.courses.new
    end
  end

  def create    
    @project = Project.find(params[:project_id])
    if params[:edu_program_id].present?
      @edu_program = EduProgram.find(params[:edu_program_id]) 
      @course = @edu_program.courses.new(resource_params)
    else
      @course = @project.courses.new(resource_params)
    end

    if @course.save
      @course.update_attributes(project_id: @project.id)
      flash[:success] = 'Курс добавлен'
      redirect_to project_path(@project, anchor: 'edu_programs')
    else
      flash[:error] = 'Курс не добавлен'
      render 'new'
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @course = Course.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @course = Course.find(params[:id])
    if @course.update_attributes(resource_params)
      flash[:success] = 'Курс обновлен'
      redirect_to project_path(@project, anchor: 'edu_programs')
    else
      flash[:error] = 'Курс не обновлен'
      render 'edit'
    end
  end

  def show
    @project = Project.find(params[:project_id])
    if params[:edu_program_id].present?
      @edu_program = EduProgram.find(params[:edu_program_id])
    end
    @course = Course.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:project_id])
    if Course.find(params[:id]).destroy
      flash[:success] = 'Курс удален'
    else
      flash[:success] = 'Курс не удален'
    end 
    redirect_to project_path(@project, anchor: 'edu_programs')
  end

  private
  def resource_params
    params.require(:course).permit!
  end
end

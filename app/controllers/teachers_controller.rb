class TeachersController < ApplicationController
  load_and_authorize_resource :course
  load_and_authorize_resource :teacher, through: :course

  def index
    @teachers = Teacher.all
  end

  def new
    @project = Project.find(params[:project_id])
    @course = Course.find(params[:course_id])
    @teacher = @course.teachers.new
  end

  def create    
    @project = Project.find(params[:project_id])
    @course = Course.find(params[:course_id])
    @teacher = @course.teachers.new(resource_params)

    if @teacher.save
      flash[:success] = 'Учитель добавлен'
      redirect_to project_course_path(@project, @course)
    else
      flash[:error] = 'Учитель не добавлен'
      render 'new'
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @course = Course.find(params[:course_id])
    @teacher = Teacher.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @course = Course.find(params[:course_id])
    @teacher = Teacher.find(params[:id])

    if @teacher.update_attributes(resource_params)
      flash[:success] = 'Учитель обновлен'
      redirect_to project_course_path(@project, @course)
    else
      flash[:error] = 'Учитель не обновлен'
      render 'edit'
    end
  end

  def show
    @project = Project.find(params[:project_id])
    @course = Course.find(params[:course_id])
    @teacher = Teacher.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:project_id])
    @course = Course.find(params[:course_id])
    @teacher = Teacher.find(params[:id])
    
    if @teacher.destroy
      flash[:success] = 'Учитель удален'
    else
      flash[:success] = 'Учитель не удален'
    end 
    redirect_to project_course_path(@project, @course)
  end

  private
  def resource_params
    params.require(:teacher).permit!
  end
end

class StudentsController < ApplicationController
  load_and_authorize_resource :edu_program
  load_and_authorize_resource :student, through: :edu_program

  def index
    @students = Student.all
  end

  def new
    @project = Project.find(params[:project_id])
    @edu_program = EduProgram.find(params[:edu_program_id]) 
    @student = @edu_program.students.new
  end

  def create    
    @project = Project.find(params[:project_id])
    @edu_program = EduProgram.find(params[:edu_program_id]) 
    @student = @edu_program.students.new(resource_params)
    if @student.save
      flash[:success] = 'Студент добавлен'
      redirect_to project_path(@project, anchor: 'edu_programs')
    else
      flash[:error] = 'Студент не добавлен'
      render 'new'
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @edu_program = EduProgram.find(params[:edu_program_id])
    @student = Student.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @edu_program = EduProgram.find(params[:edu_program_id])
    @student = Student.find(params[:id])
    if @student.update_attributes(resource_params)
      flash[:success] = 'Студент обновлен'
      redirect_to project_path(@project, anchor: 'edu_programs')
    else
      flash[:error] = 'Студент не обновлен'
      render 'edit'
    end
  end

  def show
    @project = Project.find(params[:project_id])
    @edu_program = EduProgram.find(params[:edu_program_id]) 
    @student = Student.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:project_id])
    @edu_program = EduProgram.find(params[:edu_program_id])
    if Student.find(params[:id]).destroy
      flash[:success] = 'Студент удален'
    else
      flash[:success] = 'Студент не удален'
    end 
    redirect_to project_path(@project, anchor: 'edu_programs')
  end

  private
  def resource_params
    params.require(:student).permit!
  end
end

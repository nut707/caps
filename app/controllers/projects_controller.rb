class ProjectsController < ApplicationController
  load_and_authorize_resource

  def index
    @projects = Project.unscoped.all.order(created_at: :desc)
    if params[:export_projects].present?
      @projects = @projects.find(params[:export_projects].map(&:to_i))
    else
      @filterrific = initialize_filterrific(
        @projects,
        params[:filterrific],
        select_options: {
          with_type: Project.all.map { |p| [p.type.constantize.model_name.human, p.type] }.uniq
        }
      ) or return
      @projects = @filterrific.find.includes(:participants)
    end

    respond_to do |format|
      format.html
      format.js
      format.xlsx
    end
  end

  def new
    @project  = eval params[:type].camelize+'.new'
    @research = @project.researches.new
    @course = @project.courses.new
  end

  def create
    @project = eval params[:project][:type].camelize+'.new(project_params)'
    @project.status = :draft
    @research = @project.researches.last#объект для ошибок валидации SimpleForm
    @course = @project.courses.last#объект для ошибок валидации SimpleForm

    @project.participants << Participant.new(profile_id: current_user.profile.id, role_id: Role.find_by(name:'Руководитель проекта').id)
    if @project.save
      flash[:success]='Проект создан'
      redirect_to :action => "my"
    else
      flash[:error]= "Вы заполнили не все поля"
      render "new", type: params[:project][:type]
    end
  end

  def edit
    @project = Project.find(params[:id])
    @research = @project.researches.last
    @course = @project.courses.last
  end

  def update
    @project = Project.find(params[:id])
    
    if @project.update_attributes(project_params)

      if params['draft'].present?
        @project.update_attributes(status: 0)
      elsif params['confirming'].present?
        @project.update_attributes(status: 1)
      elsif params['confirmed'].present?
        @project.update_attributes(status: 2)
      elsif params['archive'].present?
        @project.update_attributes(status: 3)
      end

      if current_user.is_admin? 
        redirect_to :action => "index"
      else 
        redirect_to :action => "my"
      end
    else
      render 'edit'
    end
  end

  def show
    @project=Project.find(params[:id])
    @participants = @project.participants.includes(:role)
    @profiles = @project.profiles.includes(:stays)
    @profiles_publications = Publication.joins(:profiles).where('profiles.id in (?)', @profiles.pluck(:id)).uniq.includes(:external_authors, :projects)
    @publications = @project.publications.includes(:external_authors)
    @researches = @project.try(:researches).includes(:science_branches,:activity_directions)
    @events = @project.events.includes(:participant).order(created_at: :desc)
    @edu_programs = @project.edu_programs.includes(:courses, :students).order(created_at: :desc)
    @courses = @project.courses.order(created_at: :desc)
  end

  def my
    @projects = current_user.profile.projects.actual.includes(:participants).uniq
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.draft?
      Project.find(params[:id]).destroy
    else
      flash[:error]='Удалять можно только черновики'
    end
    redirect_to :back
  end

  def change_status
    Project.find(params[:id]).update_attributes(status: params[:status].to_i)
    if current_user.is_admin? 
      redirect_to :action => "index"
    else 
      render "my" 
    end
  end

  def add_publication
    @project = Project.find(params[:id])
    @publication = Publication.find(params[:publication_id])
    @project.publications << @publication
    @project.save
    @publications = @project.publications
    @profiles = @project.profiles
    @profiles_publications = Publication.joins(:profiles).where('profiles.id in (?)', @profiles.pluck(:id)).uniq
    respond_to do |format|
      format.js
    end
  end

  def remove_publication
    @project = Project.find(params[:id])
    @publication = Publication.find(params[:publication_id])
    @project.publications.delete(@publication)
    @publications = @project.publications
    @profiles = @project.profiles
    @profiles_publications = Publication.joins(:profiles).where('profiles.id in (?)', @profiles.pluck(:id)).uniq
    render template: 'projects/add_publication.js.erb'
  end

  private
  def project_params
    params.require(:project).permit!
  end
end

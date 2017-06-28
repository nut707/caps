class OtherEventsController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :other_event, through: :project

  def new
    @project = Project.find(params[:project_id])
    @other_event=OtherEvent.new
  end

  def create
    @project = Project.find(params[:project_id])
    @other_event=@project.other_events.new(other_event_params)
    if @other_event.save
      flash[:success]='Иное мероприятие добавлено'
      redirect_to project_path(@project, anchor: 'other_events')
    else
      flash[:error]='Иное мероприятие не добавлено'
      render 'new'
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @other_event=OtherEvent.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @other_event=OtherEvent.find(params[:id])
    if @other_event.update_attributes(other_event_params)
      flash[:success]='Иное мероприятие обновлено'
      redirect_to project_path(@project, anchor: 'other_events')
    else
      flash[:error]='Иное мероприятие не обновлено'
      render 'edit'
    end
  end
 
  def destroy
    @project = Project.find(params[:project_id])
    if OtherEvent.find(params[:id]).destroy
      flash[:success]='Иное мероприятие удалено'
    else
      flash[:success]='Иное мероприятие не удалено'
    end 
    redirect_to project_path(@project, anchor: 'other_events')
  end

  def show
    @other_event=OtherEvent.find(params[:id])
  end

  private
  def other_event_params
    params.require(:other_event).permit!
  end
end

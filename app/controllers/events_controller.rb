class EventsController < ApplicationController
  require "date"

  load_and_authorize_resource :project
  load_and_authorize_resource :event, through: :project

  def new
    @project = Project.find(params[:project_id])
    @event=Event.new
  end

  def create
    @project = Project.find(params[:project_id])
    @event=@project.events.new(event_params)
    if @event.save
      flash[:success]='Мероприятие добавлено'
      redirect_to project_path(@project, anchor: 'events')
    else
      flash[:error]='Мероприятие не добавлено'
      render 'new'
    end
  end

  def add_report
    @project = Project.find(params[:project_id])
    @event=Event.find(params[:id])
    @event.update_attributes(report: params[:event][:report], report_date: DateTime.now)
    respond_to do |format|
      format.js
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @event=Event.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @event=Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:success]='Мероприятие обновлено'
      redirect_to project_path(@project, anchor: 'events')
    else
      flash[:error]='Мероприятие не обновлено'
      render 'edit'
    end
  end
 
  def destroy
    @project = Project.find(params[:project_id])
    if Event.find(params[:id]).destroy
      flash[:success]='Мероприятие удалено'
    else
      flash[:success]='Мероприятие не удалено'
    end 
    redirect_to project_path(@project, anchor: 'events')
  end

  private
  def event_params
    params.require(:event).permit!
  end
end

class ParticipantsController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource through: :project, :except => [:role_fields_form]

  autocomplete :profile, :last_name, :extra_data => [:first_name, :middle_name], :display_value => :fio
  
  def new
    @project = Project.find(params[:project_id])
    @participant = @project.participants.new
  end

  def create
    if params[:role_fields_values].present?
      given_fields_amount = params[:role_fields_values].map{|x| x[:value]}.reject{|c| c.empty?}.length
      expected_fields_amount = Role.find(params[:participant][:role_id]).role_fields.count

      if given_fields_amount == expected_fields_amount

        @project = Project.find(params[:project_id])
        @participant = @project.participants.new(resource_params)

        if @project.save        
          params[:role_fields_values].each do |role_fields_value|
            RoleFieldValue.create(value: role_fields_value[:value], role_field_id: role_fields_value[:role_field_id], participant_id: @participant.id)
          end
          flash[:success]='Участник успешно добавлен.'
          redirect_to project_path(@project, anchor: 'participants')
        else
          flash[:error]='Участник не добавлен. Возможно вы не заполнили все обязательные поля.'
          render 'new'
        end
      else
        flash[:error]='Участник не добавлен. Вы не заполнили дополнительные поля роли участника.'
        render 'new'
      end

    else

      @project = Project.find(params[:project_id])
      @participant = @project.participants.new(resource_params)
      

      if @project.save
        flash[:success]='Участник успешно добавлен.'
        redirect_to project_path(@project, anchor: 'participants')
      else
        flash[:error]='Участник не добавлен. Возможно вы не заполнили все обязательные поля.'
        render 'new'
      end

    end
    
    rescue ActiveRecord::RecordNotFound 
      flash[:error] = 'Нет такого пользователя'
      render 'new'
  end

  def edit
    @project = Project.find(params[:project_id])
    @participant = Participant.find(params[:id])
    @role_fields = @participant.role.role_fields
  end

  def update
    @participant = Participant.find(params[:id])
    if @participant.update_attributes(resource_params)
      flash[:success]='Участник успешно добавлен.'
      redirect_to project_path(@participant.project, anchor: 'participants')
    else
      flash[:error]='Участник не добавлен. Возможно вы не заполнили все обязательные поля.'
      render 'new'
    end
  end

  def role_fields_form
    @role=Role.find(params[:role_id])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    if Participant.find(params[:id]).destroy
      flash[:success]='Участник удален'
      redirect_to project_path(@project, anchor: 'participants')
    else
      flash[:error]='Участник не удален'
      redirect_to project_path(@project, anchor: 'participants')
    end
  end

  private
  def resource_params
    params.require(:participant).permit!
  end
end
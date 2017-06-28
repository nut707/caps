class ExpensePeriodsController < ApplicationController
  before_action :set_expense_period, only: [:show, :edit, :update, :destroy]

  # GET /expense_periods
  # def index
  #   @project = Project.find(params[:project_id])
  #   @expense_periods = @project.expense_periods
  # end

  # GET /expense_periods/1
  def show
    @project = @expense_period.project
  end

  # GET /expense_periods/new
  def new
    @project = Project.find(params[:project_id])
    @expense_period = @project.expense_periods.new
  end

  # GET /expense_periods/1/edit
  def edit
    @project = @expense_period.project
  end

  # POST /expense_periods
  def create
    @project = Project.find(params[:project_id])
    @expense_period = @project.expense_periods.new(expense_period_params)

    if @project.save
      redirect_to project_path(@project, anchor: 'finances'), notice: 'Период расхода успешно создан.'
    else
      render :new
    end
  end

  # PATCH/PUT /expense_periods/1
  def update
    if @expense_period.update(expense_period_params)
      redirect_to project_path(@expense_period.project, anchor: 'finances'), notice: 'Период расхода успешно обновлен.'
    else
      render :edit
    end
  end
  
  # DELETE /expense_periods/1
  def destroy
    @project = @expense_period.project
    if @expense_period.destroy
      flash[:notice] = 'Период расхода успешно удален.'
    else
      flash[:error] = @expense_period.errors.full_messages.to_sentence
    end
    redirect_to project_path(@project, anchor: 'finances')
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense_period
      @expense_period = ExpensePeriod.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def expense_period_params
      params.require(:expense_period).permit(:start, :finish, :name)
    end
end

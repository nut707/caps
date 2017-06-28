class PlannedExpensesController < ApplicationController
  before_action :set_planned_expense, only: [:show, :edit, :update, :destroy]

  # GET /planned_expenses
  def index
    @planned_expenses = @project.planned_expenses
  end

  # GET /planned_expenses/1
  def show
  end

  # GET /planned_expenses/new
  def new
    @project = Project.find(params[:project_id])
    @planned_expense = PlannedExpense.new
  end

  # GET /planned_expenses/1/edit
  def edit
  end

  # POST /planned_expenses
  def create
    @project = Project.find(params[:project_id])
    @planned_expense = PlannedExpense.new(planned_expense_params)

    if @planned_expense.save
      redirect_to project_path(@project, anchor: 'finances'), notice: 'Плановые расходы успешно создан.'
    else
      render :new
    end
  end

  # PATCH/PUT /planned_expenses/1
  def update
    if @planned_expense.update(planned_expense_params)
      redirect_to project_path(@project, anchor: 'finances'), notice: 'Плановые расходы успешно обновлен.'
    else
      render :edit
    end
  end
  
  # DELETE /planned_expenses/1
  def destroy
    if @planned_expense.destroy
      flash[:notice] = 'Плановые расходы успешно удален.'
    else
      flash[:error] = @planned_expense.errors.full_messages.to_sentence
    end
    redirect_to project_path(@project, anchor: 'finances')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_planned_expense
      @planned_expense = PlannedExpense.find(params[:id])
      @project = Project.find(params[:project_id])
    end

    # Only allow a trusted parameter "white list" through.
    def planned_expense_params
      params.require(:planned_expense).permit(:value, :expense_period_id, :expense_item_id)
    end
end

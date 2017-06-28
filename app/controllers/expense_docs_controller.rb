class ExpenseDocsController < ApplicationController
  before_action :set_expense_doc, only: [:show, :edit, :update, :destroy]

  # GET /expense_docs
  def index
    @expense_docs = ExpenseDoc.all
  end

  # GET /expense_docs/1
  def show
  end

  # GET /expense_docs/new
  def new
    @project = Project.find(params[:project_id])
    @expense_doc = ExpenseDoc.new
  end

  # GET /expense_docs/1/edit
  def edit
  end

  # POST /expense_docs
  def create
    @project = Project.find(params[:project_id])
    @expense_doc = ExpenseDoc.new(expense_doc_params)

    if @expense_doc.save
      redirect_to project_path(@project, anchor: 'finances'), notice: 'Расходный документ успешно создан.'
    else
      render :new
    end
  end

  # PATCH/PUT /expense_docs/1
  def update
    if @expense_doc.update(expense_doc_params)
      redirect_to project_path(@project, anchor: 'finances'), notice: 'Расходный документ успешно обновлен.'
    else
      render :edit
    end
  end
  
  # DELETE /expense_docs/1
  def destroy
    @expense_doc.destroy
    redirect_to project_path(@project, anchor: 'finances'), notice: 'Расходный документ успешно удален.'
  end

  def reserve_docs_list
    @planned_expense = PlannedExpense.find(params[:planned_expense_id])
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense_doc
      @project = Project.find(params[:project_id])
      @expense_doc = ExpenseDoc.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def expense_doc_params
      params.require(:expense_doc).permit(:planned_expense_id, :reserve_doc_id, :date, :number, :cfo, :contragent, :payment_purpose, :sum, :responsible, :comment)
    end
end

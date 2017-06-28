class ExpenseItemsController < ApplicationController
  before_action :set_expense_item, only: [:show, :edit, :update, :destroy]

  # GET /expense_items
  def index
    @expense_items = ExpenseItem.all
  end

  # GET /expense_items/1
  def show
  end

  # GET /expense_items/new
  def new
    @expense_item = ExpenseItem.new
  end

  # GET /expense_items/1/edit
  def edit
  end

  # POST /expense_items
  def create
    @expense_item = ExpenseItem.new(expense_item_params)

    if @expense_item.save
      redirect_to @expense_item, notice: 'Статья расходов успешно создан.'
    else
      render :new
    end
  end

  # PATCH/PUT /expense_items/1
  def update
    if @expense_item.update(expense_item_params)
      redirect_to @expense_item, notice: 'Статья расходов успешно обновлен.'
    else
      render :edit
    end
  end
  
  # DELETE /expense_items/1
  def destroy
    @expense_item.destroy
    redirect_to expense_items_url, notice: 'Статья расходов успешно удален.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense_item
      @expense_item = ExpenseItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def expense_item_params
      params.require(:expense_item).permit(:code, :name)
    end
end

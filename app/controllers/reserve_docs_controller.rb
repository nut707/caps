class ReserveDocsController < ApplicationController
  before_action :set_reserve_doc, only: [:show, :edit, :update, :destroy]

  # GET /reserve_docs
  def index
    @reserve_docs = ReserveDoc.all
  end

  # GET /reserve_docs/1
  def show
  end

  # GET /reserve_docs/new
  def new
    @project = Project.find(params[:project_id])
    @reserve_doc = ReserveDoc.new
  end

  # GET /reserve_docs/1/edit
  def edit
  end

  # POST /reserve_docs
  def create
    @project = Project.find(params[:project_id])
    @reserve_doc = ReserveDoc.new(reserve_doc_params)

    if @reserve_doc.save
      redirect_to project_path(@project, anchor: 'finances'), notice: 'Резервный документ успешно создан.'
    else
      render :new
    end
  end

  # PATCH/PUT /reserve_docs/1
  def update
    if @reserve_doc.update(reserve_doc_params)
      redirect_to project_path(@project, anchor: 'finances'), notice: 'Резервный документ успешно обновлен.'
    else
      render :edit
    end
  end
  
  # DELETE /reserve_docs/1
  def destroy
    @reserve_doc.destroy
    redirect_to project_path(@project, anchor: 'finances'), notice: 'Резервный документ успешно удален.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reserve_doc
      @project = Project.find(params[:project_id])
      @reserve_doc = ReserveDoc.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def reserve_doc_params
      params.require(:reserve_doc).permit(:planned_expense_id, :date, :number, :cfo, :contragent, :payment_purpose, :sum, :from, :to, :responsible, :comment)
    end
end

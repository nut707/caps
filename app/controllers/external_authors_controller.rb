class ExternalAuthorsController < ApplicationController
  load_and_authorize_resource :publication
  load_and_authorize_resource :external_author, through: :publication

  def index
    @extauthors = ExternalAuthor.all
  end

  def new
    @publication = Publication.find(params[:publication_id])
    @extauthor = ExternalAuthor.new
  end

  def create
    @publication = Publication.find(params[:publication_id])
    @extauthor = ExternalAuthor.create(resource_params)
    @publication.external_authors << @extauthor
    if @publication.save
      flash[:success]='Внешний соавтор добавлен'
      redirect_to my_publications_path
    else
      flash[:error]='Не вышло'
      render 'new'
    end
  end

  def edit
    @extauthor=Extauthor.find(params[:id])
  end

  def update
    @extauthor=extauthor.find(params[:id])
    @extauthor.update_attributes(resource_params)
    render 'edit'
  end

  def destroy
    @extauthor = ExternalAuthor.find(params[:id])
    if @extauthor.destroy
      flash[:success]='Внешний соавтор удален'
      respond_to do |format|
        format.html
        format.js
      end
      
    else
      flash[:error]='Не вышло'
      redirect_to :back
    end
  end

  private
  def resource_params
    params.require(:external_author).permit!
  end
end

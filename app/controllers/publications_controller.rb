class PublicationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  autocomplete :profile, :last_name, :extra_data => [:first_name, :middle_name], :display_value => :fio
  

  def index
    @publications = Publication.all.includes(:external_authors)
  end

  def new
    @publication = Publication.new
  end

  def create
    @publication = Publication.new(publication_params)
    @author = current_user.profile
    @publication.author_id = @author.id

    if @publication.save
      @author.publications << @publication
      @author.save
      redirect_to :action => "my"
    else
      render 'new'
    end
  end

  def show
    @publication = Publication.find(params[:id])
  end

  def my
    # @publications=Publication.where(author_id: current_user.profile.id)
    @publications=current_user.profile.publications.includes(:external_authors)
  end

  def edit
    @publication=Publication.find(params[:id])
  end

  def update
    @publication=Publication.find(params[:id])
    if @publication.update_attributes(publication_params)
      redirect_to :action => "my"
    else
      render 'edit'
    end
  end

  def destroy
    Publication.find(params[:id]).destroy
    flash[:success]='Публикация удалена'
    redirect_to :back
  end

  def add_author
    @publication = Publication.find(params[:id])
  end

  def add_author_update
    @publication = Publication.find(params[:id])
    @profile = Profile.find(params[:profile][:id])

    if @profile.id != @publication.author_id
      @publication.profiles << Profile.find(params[:profile][:id])
    else
      flash[:warning] = 'Такой автор уже есть у этой публикации' 
      render :add_author
      return false
    end

    if @publication.save
      flash[:success]='Автор успешно добавлен.'
      redirect_to action: 'my'
    else
      flash[:error]='Автор не добавлен'
      render :add_author
    end

    rescue ActiveRecord::RecordNotUnique 
      flash[:warning] = 'Такой автор уже есть у этой публикации' 
      render :add_author
    rescue ActiveRecord::RecordNotFound 
      flash[:error] = 'Нет такого автора'
      render :add_author
  end

  def author_remove
    @profile = Profile.find(params[:id])
    @publication = Publication.find(params[:publication_id])
    @publication.profiles.delete(@profile)
    respond_to do |format|
      format.js
    end
  end

  private
  def publication_params
    params.require(:publication).permit!
  end
end

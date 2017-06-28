class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  before_action :user_must_have_profile, only: [:index]

  def after_sign_in_path_for(resource_or_scope)
    home_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  private
  def user_must_have_profile
    unless current_user.profile.present?
      flash[:error]='Заполните свой профиль'
      redirect_to new_profile_path
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      flash[:error]='Недостаточно прав'
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { 
        flash[:error] = 'Недостаточно прав'
        if request.env["HTTP_REFERER"].present?
          redirect_to :back
        else
          redirect_to root_path
        end 
      }
      format.js { render 'shared/ajax_errors', flash: flash}
    end
    
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

end

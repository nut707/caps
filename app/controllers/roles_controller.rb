class RolesController < ApplicationController
  def edit
    @role=Role.find(params[:id])
  end

  def update
  end

  private
    def role_params
      params.require(:role).permit!
    end
end
class HomeController < ApplicationController
  def index
    @projects = current_user.profile.projects.uniq
    @events = current_user.profile.events.includes(:project)
  end
end

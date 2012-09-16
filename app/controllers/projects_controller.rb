class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id], :include => [ :users, :photos] )
    @photos = @project.photos;
  end
end

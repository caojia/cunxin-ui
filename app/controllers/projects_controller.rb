class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id], :include => [:charity, :users, :photos] )
    @photos = @project.photos;
  end
end

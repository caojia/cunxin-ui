class ProjectController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @project = Project.find(params[:id], :include => :users)
  end
end

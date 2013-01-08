class Admin::ProjectsController < ApplicationController
  layout "layouts/admin"

  def index
    @projects = Project.find(:all, :order => "id desc")
  end

  def new
    @project = Project.new
  end
end

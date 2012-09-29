class ProjectsController < ApplicationController
  include SinaClient
  before_filter :authenticate_user!, :only => [:follow, :unfollow]

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id], :include => [:charity, :users, :photos] )
    @photos = @project.photos;
    @donated_users = @project.donated_users;
  end

  def notice
    user = current_user
    project_id = params[:project_id]
    unless user.blank?
      user_project =
        UserProject.find(:first, :conditions => {:user_id => user.id, :project_id => project_id} ) ||
        UserProject.new(:user_id => user.id, :project_id => project_id)
      user_project.followed_at = Time.now.utc
      user_project.is_deleted = false
      user_project.save
    end
    render :json => {
      :info => t('projects.notice_thanks'),
      :total_noticed => Project.find(project_id).count_noticed_users }.to_json
  end
end

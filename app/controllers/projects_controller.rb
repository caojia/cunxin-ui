class ProjectsController < ApplicationController
  include SinaClient
  before_filter :authenticate_user!, :only => [:follow, :unfollow]

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id], :include => [:charity, :photos] )
    @photos = @project.photos;
    @donated_users = @project.donated_users;
  end

  def follow
    project = Project.find(params[:id].to_i)
    total_followed = 0
    if !project.blank?
      current_user.follow(project) do |user|
        if !user.sina_oauth_user.blank?
          token = sina_client.get_token_from_hash({
            :access_token => user.sina_oauth_user.oauth_token,
            :expires_at => user.sina_oauth_user.oauth_token_expires_at })
          if token.validated?
            # TODO: upload the image too?
            logger.info "updating sina weibo status"
            sina_client.statuses.update(
              t("projects.sina_follow_message", 
                :project_name => project.headline,
                :url => project_path(project, :only_path => false)))
          end
        end
      end
      total_followed = project.followed_users.count
    end
    render :json => {
      :info => t('projects.follow_thanks'),
      :total_followed => total_followed }.to_json
  end
end

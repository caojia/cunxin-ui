class ProjectsController < ApplicationController
  include SinaClient
  before_filter :authenticate_user!, :only => [:follow, :unfollow, :check_following]

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id], :include => [:charity, :photos])
    @photos = @project.photos
    @payments = @project.finished_payments
    @projects = Project.find(:all, :limit => 5).reject {|proj| proj == @project}
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
            begin
              sina_client.statuses.update(
                t("projects.sina_follow_message", 
                  :project_name => project.headline,
                  :url => project_path(project, :only_path => false)))
            rescue
              logger.error $!
            end
          end
        end
      end
      total_followed = project.followed_users.count
    end
    render :json => {
      :info => t('projects.follow_thanks'),
      :total_followed => total_followed }.to_json
  end

  def unfollow
    project = Project.find(params[:id].to_i)
    if !project.blank?
      current_user.unfollow(project)
    end
    render :json => {
      :success => true }.to_json
  end

  def check_following
    following = current_user.following?(params[:id].to_i)
    render :json => {:is_following => following}.to_json
  end
end

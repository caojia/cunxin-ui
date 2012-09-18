class ProfileController < ApplicationController
  before_filter :authenticate_user!
  before_filter :prepare_tabs

  def index
    @user = current_user
    @profile_tabs_hash["account"][:class] = "active"
    @partial = "account"
  end

  def projects
    @profile_tabs_hash["projects"][:class] = "active"
    @partial = "projects"
    render :action => :index
  end

  protected
    def prepare_tabs
      @profile_tabs = [
        { :name => "projects",
          :link => projects_profile_path },
        { :name => "account",
          :link => profile_path }
      ]
      @profile_tabs_hash = {}
      @profile_tabs.each do |t| 
        @profile_tabs_hash[t[:name]] = t
      end
    end
end

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

    # TODO: pagination
    @projects = current_user.followed_projects 
    render :action => :index
  end

  def update
    @profile = current_user.profile
    json_response_for_update(@profile, Profile::FIELDS) do
      @profile.update_attributes(params[:profile])
    end
  end

  # update user fields
  def update_email
    user = current_user
    user.email = params[:user][:email]
    json_response_for_update(user, [:email]) do
      user.save
    end
  end

  def update_name
    user = current_user
    user.name = params[:user][:name]
    json_response_for_update(user, [:name]) do
      user.save
    end
  end

  def update_password
    user = current_user
    json_response_for_update(user, []) do
      user.update_with_password(params[:user])
    end
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

    def json_response_for_update resource, fields, &block
      result = yield
      if result
        sign_in_with_cookie(resource, :bypass => true) if User === resource 
        render :json => resource.to_json(:only => fields)
      else
        render :json => resource.errors.to_json, :status => :unprocessable_entity
      end
    end
end

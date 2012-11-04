class UsersController < ApplicationController
  include Devise::Controllers::Helpers
  #before_filter :authenticate_user!, :except => [:complete, :signup]
  skip_before_filter :reset_sina_user_from_session, :only => [:new, :create]

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def new
    return(redirect_to root_path) if current_user
    @user = User.new
    @is_complete = false
    # Process for sina
    @sina_user_id = nil
    sina_user = verified_sina_oauth_user
    if sina_user
      @user.name = sina_user.name
      @signup_title = t("signup.complete_title")
      @sina_user_id = params[:sina_id]
      @is_complete = true
    end
  end

  # NOTE: we only use devise for login/logout in controller
  # 
  def create
    @user = User.new(params[:user])
    @is_complete = false
    
    # Process sina
    sina_user = verified_sina_oauth_user
    @sina_user_id = nil
    @sina_oauth_user = nil
    if sina_user
      logger.info "sina_user"
      @user.thumbnail = sina_user.profile_image_url
      @user.thumbnail_updated_at = Time.now.utc
      @sina_user_id = params[:sina_id]
      @sina_oauth_user = SinaOauthUser.find(Base64.decode64(params[:sina_id]))
      @is_complete = true
    end

    if @user.save_and_set_oauth(@sina_oauth_user)
      expire_session_data_after_sign_in!
      reset_oauth_user_from_session("sina")
      sign_in(@user)

      redirect_to root_path
    else
      @user.clean_up_passwords
      #TODO: show error messages
      render :action => :new
    end

  end

  def show
    @user = User.find(params[:id])
  end

  private
    def verified_sina_oauth_user
      if !params[:sina_id].blank? 
        sina_user_in_session = get_oauth_user_from_session("sina")
        sina_id = Base64.decode64(params[:sina_id])
        if sina_user_in_session && sina_user_in_session[:id] == sina_id
          @user.name = sina_user_in_session[:sina_user].name
          return sina_user_in_session[:sina_user]
        end
      end
      return nil
    end

end

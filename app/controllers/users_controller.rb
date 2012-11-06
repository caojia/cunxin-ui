class UsersController < ApplicationController
  include Devise::Controllers::Helpers
  #before_filter :authenticate_user!, :except => [:complete, :signup]
  skip_before_filter :reset_sina_user_from_session, :only => [:new, :create, :bind_account, :bind_account_auth_failure]

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def bind_account
    @user = User.new
    sina_user = verified_sina_oauth_user

    if !verified_sina_oauth_user
      render :json => {:error => t("signup.complete.bind.invalid_sina_account")}.to_json
    else
      oauth_in_session = get_oauth_user_from_session("sina")
      allow_params_authentication!
      authenticate_user!(:recall => "users#bind_account_auth_failure")
      if current_user.sina_connected?
        sign_out
        set_oauth_user_to_session("sina", oauth_in_session)
        return render(:json => {:error => t("signup.complete.bind.already_binded")}.to_json)
      end
      current_user.thumbnail = sina_user.profile_image_url
      current_user.thumbnail_updated_at = Time.now.utc
      @sina_oauth_user = SinaOauthUser.find(Base64.decode64(params[:sina_id]))

      if @user.save_and_set_oauth(@sina_oauth_user)
        expire_session_data_after_sign_in!
        reset_oauth_user_from_session("sina")
        sign_in(@user)
        return render(:json => {:success => true}.to_json)
      else
        sign_out
        set_oauth_user_to_session("sina", oauth_in_session)
        return render(:json => {:error => "signup.complete.bind.bind_failure"}.to_json)
      end
    end
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

  def bind_account_auth_failure
    render :json => {:error => t("signup.complete.bind.invalid_cunxin_account")}.to_json
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

class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  before_filter :check_accessible

  before_filter :reset_sina_user_from_session

  def auth_error_callback
    clear_user_cookie
    if request.xhr?
      render :json => {:error => t("devise.failure.unauthenticated")}, :status => 401
    else
      redirect_to root_path
    end
  end

  def signin_error_callback
    clear_user_cookie
    if request.xhr?
      render :json => {:error => flash[:alert]}, :status => 401
    else
      redirect_to root_path
    end
  end

  protected
    def sina_token_validation access_token, expires_at
      client = WeiboOAuth2::Client.new
      if access_token && !client.authorized?
        token = client.get_token_from_hash({
          :access_token => access_token,
          :expires_at => expires_at
        })
        unless token.validated?
          redirect_to :action => :connect, :controller => :sina
          return false
        end
      end
      return !access_token.nil?
    end

    # Oauth related
    def get_oauth_user_from_session(provider)
      session[oauth_session_key(provider)]
    end

    def reset_oauth_user_from_session(provider)
      session[oauth_session_key(provider)] = nil
    end

    def set_oauth_user_to_session(provider, content)
      session[oauth_session_key(provider)] = content
    end

    def oauth_session_key(provider)
      ("%s_oauth_user" % provider).to_sym
    end

    def reset_sina_user_from_session
      reset_oauth_user_from_session("sina")
    end

    def sign_in_with_cookie user, *args
      sign_in_without_cookie(user, *args)
      if !(User === user)
        user = args.last
      end
      remember_expires_at = user.remember_expires_at rescue nil
      cookies[:_cunxin_name] = {
        :value => user.name, 
        :expires => remember_expires_at }
      cookies[:_cunxin_thumb] = {
        :value => user.thumbnail_url,
        :expires => remember_expires_at }
      cookies[:_cunxin_id] = {
        :value => user.id,
        :expires => remember_expires_at }
    end
    alias_method_chain :sign_in, :cookie

    def sign_out_with_cookie *args
      sign_out_without_cookie(*args)
      clear_user_cookie
    end
    alias_method_chain :sign_out, :cookie

    def clear_user_cookie
      cookies.delete :_cunxin_id
      cookies.delete :_cunxin_name
      cookies.delete :_cunxin_thumb
    end

    def authenticate_user_with_recall! opts={}
      opts[:recall] ||= "application#auth_error_callback"
      authenticate_user_without_recall!(opts)
    end
    alias :authenticate_user_without_recall! :authenticate_user! 
    alias :authenticate_user! :authenticate_user_with_recall!

    def check_accessible
      if action_name != "about"
        redirect_to "/about"
      end
    end

end


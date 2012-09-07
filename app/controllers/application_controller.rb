class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
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


end


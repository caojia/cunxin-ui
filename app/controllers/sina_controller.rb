class SinaController < ApplicationController
  include SinaClient
  def connect
    redirect_to sina_client.authorize_url
  end

  def callback
    client = sina_client
    begin
      access_token = client.auth_code.get_token(params[:code].to_s)
      # 1. if it is a already connected account, login directly
      # 2. otherwise, prompt a complete account form
      if sina_token_validation(access_token.token, access_token.expires_at)
        # update or insert the sina oauth user
        uid = access_token.params["uid"]
        sina_oauth_user = SinaOauthUser.find_or_new(uid)
        sina_oauth_user.oauth_token = access_token.token
        sina_oauth_user.oauth_token_expires_at = access_token.expires_at
        sina_oauth_user.save

        sina_user = client.users.show_by_uid(uid)
        # existed user
        if (user = sina_oauth_user.user)
          user.thumbnail = sina_user.profile_image_url
          user.thumbnail_updated_at = Time.now.utc
          user.save

          sign_in(user)
          redirect_to root_path
        else
          set_oauth_user_to_session("sina", {:id => sina_oauth_user.id.to_s, :sina_user => sina_user})
          redirect_to signup_path(:complete => 1, :sina_id => Base64.encode64(sina_oauth_user.id.to_s))
        end
      end
    rescue
      # TODO: add more info
      raise $!
    end
  end

end

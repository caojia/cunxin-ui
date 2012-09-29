module SinaClient
  def sina_client
    @sina_client ||= WeiboOAuth2::Client.new
  end
end

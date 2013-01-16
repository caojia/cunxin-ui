class SinaOauthUser < OauthUser
  validates_uniqueness_of :oauth_uid, :scope => :type

  def self.find_or_new uid
    u = find(:first, :conditions => ["oauth_uid = ?", uid.to_s]) 
    u.nil? ? new(:oauth_uid => uid.to_s) : u
  end

  def sina_link
    "http://www.weibo.com/u/#{oauth_uid}"
  end

end

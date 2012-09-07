class OauthUser < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_protected :id, :type

  belongs_to :user
end

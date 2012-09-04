class User < ActiveRecord::Base
  attr_protected :sina_token, :password

  validates_presence_of :password
  validates_presence_of :login
  validates_presence_of :email

  validates_uniqueness_of :login
  validates_uniqueness_of :email

  has_many :user_projects
  has_many :followed_projects, :through => :user_projects, :source => :project

  #TODO: password generation

end

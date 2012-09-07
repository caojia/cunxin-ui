class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :thumbnail, :thumbnail_updated_at

  has_many :user_projects
  has_many :followed_projects, :through => :user_projects
  has_one :sina_oauth_user
  has_one :profile

  after_create :create_profile

  def save_and_set_oauth(oauth_user)
    return false if oauth_user && !oauth_user.user_id.blank?
    result = true
    User.transaction do 
      result = self.save && result
      if (oauth_user)
        oauth_user.user_id = self.id
        result = oauth_user.save && result
      end
    end
    result
  end

end

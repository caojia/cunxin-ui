class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :agree_pp
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :thumbnail, :thumbnail_updated_at, :agree_pp

  has_many :user_projects
  has_many :followed_projects, :through => :user_projects
  has_one :sina_oauth_user
  has_one :profile

  validates :agree_pp, :acceptance => true, :on => :create
  validates_presence_of :name

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

  # NOTE: overwite the default confirmable's method,
  # we don't need the email is always confirmed
  def active_for_authentication?
    true
  end

end

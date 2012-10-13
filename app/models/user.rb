class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  DEFAULT_THUMBNAIL_URL = "/users/men.png"

  attr_accessor :agree_pp
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :thumbnail, :thumbnail_updated_at, :agree_pp

  has_many :user_projects
  has_many :followed_projects, :through => :user_projects
  has_one :sina_oauth_user
  has_one :profile

  validates :agree_pp, :acceptance => true, :on => :create
  validates_presence_of :name
  validates_uniqueness_of :name

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

  def follow project, &block
    uq = user_projects.find(:first, :conditions => { :project_id => project.id })
    if uq.nil?
      uq = user_projects.build(:project_id => project.id)
    end
    if uq.new_record? || uq.is_deleted
      uq.is_deleted = false
      uq.followed_at = Time.now.utc
      yield(self) if block_given?
    end
    uq.save
  end

  def sina_connected?
    !sina_oauth_user.nil?
  end

  def thumbnail_url
    thumbnail.blank? ? DEFAULT_THUMBNAIL_URL : thumbnail
  end

end

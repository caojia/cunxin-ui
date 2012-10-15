class Project < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_protected :pubished, :published_at

  #TODO: add more validations
  validates_presence_of :canonical_name
  validates_uniqueness_of :canonical_name

  has_many :user_projects
  has_many :followed_users, :through => :user_projects, :source => :user, :conditions => ["user_projects.is_deleted = ?", false]

  belongs_to :charity

  has_many :project_photos
  has_many :photos, :through => :project_photos, :order => 'position ASC'

  def donated_users
    # Hack
    return User.find(:all)
  end

  def donated_amount
    # TODO: use payment api
    @donated_amount ||= 10000
  end

  def donated_percentage
    @donated_percentage ||= (donated_amount.to_f / target_amount * 100).round
  end

end

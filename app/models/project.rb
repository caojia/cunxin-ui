class Project < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_protected :pubished, :published_at

  #TODO: add more validations
  validates_presence_of :canonical_name
  validates_uniqueness_of :canonical_name

  has_many :user_projects
  has_many :users, :through => :user_projects

  belongs_to :charity

  has_many :project_photos
  has_many :photos, :through => :project_photos, :order => 'position ASC'

  def count_noticed_users
    return @noticed_users_count ||= UserProject.count(:id, :conditions => { :project_id => id, :is_deleted => [false, nil] } );
  end
end

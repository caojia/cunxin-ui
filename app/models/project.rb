class Project < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_protected :published, :published_at

  #TODO: add more validations
  validates_presence_of :canonical_name
  validates_uniqueness_of :canonical_name

  has_many :user_projects
  has_many :followed_users, :through => :user_projects, :source => :user, :conditions => ["user_projects.is_deleted = ?", false]

  belongs_to :charity

  has_many :project_photos
  has_many :photos, :through => :project_photos, :order => 'position ASC'

  has_one :primary_project_photo, :class_name => "ProjectPhoto", :conditions => ["is_primary = ?", true]
  has_one :primary_photo, :through => :primary_project_photo, :source => :photo

  def donated_users
    # TODO: use real donated users
    return User.find(:all)
  end

  def finished_payments
    payments = Payment.find(:all,
                            :conditions =>{ :project_id => self.id },
                            :include => [:user] )
    return payments
  end

  def donated_amount
    # TODO: use payment api
    #@donated_amount ||= 10000
    current_amount
  end

  def donated_percentage
    @donated_percentage ||= (donated_amount.to_f / target_amount * 100).round
  end

  def thumbnail size="1280"
    primary_photo.thumb(size) rescue nil
  end

  def thumbnail_large
    primary_photo.thumbnail_large rescue nil
  end

  def thumbnail_small
    primary_photo.thumbnail_small rescue nil
  end

  def update_project_current_amount
    self.current_amount = Payment.sum(:amount,
                                      :conditions =>{ :project_id => self.id, :status => 'finish' } )
    self.save
  end

  def publish
    self.published_at = Time.now.utc
    self.published = true
  end

end

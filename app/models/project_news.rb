class ProjectNews < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_protected :id

  def self.topx x=10
    find(:all, :conditions => "published_at IS NOT NULL", :order => "position ASC, published_at DESC")
  end
end

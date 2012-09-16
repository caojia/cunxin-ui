class Photo < ActiveRecord::Base
  #attr_accessible :description, :link, :thumbnail, :title
  attr_protected :id

  validates_presence_of :link, :thumbnail

  has_many :project_photos;
end

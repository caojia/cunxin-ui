class Carousel < ActiveRecord::Base
  # attr_accessible :title, :body
  # TODO: ordering
  attr_protected :id
  belongs_to :project

  validates_presence_of :project_id
  validates_uniqueness_of :project_id
end

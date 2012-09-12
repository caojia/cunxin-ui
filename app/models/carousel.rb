class Carousel < ActiveRecord::Base
  # attr_accessible :title, :body
  # TODO: ordering
  attr_protected :id
  belongs_to :project
end

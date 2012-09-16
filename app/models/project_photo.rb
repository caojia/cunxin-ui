class ProjectPhoto < ActiveRecord::Base
  #attr_accessible :photo_id, :position, :project_id
  attr_protected :id

  belongs_to :project;
  belongs_to :photo;
end

class UserProject < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_protected :is_deleted, :deleted_at

  belongs_to :user
  belongs_to :project

end

class Charity < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_protected :id

  #TODO: add validations

  has_many :projects
end

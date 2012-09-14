class Charity < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_protected :id

  #TODO: add more validations
  validates_presence_of :canonical_name
  validates_uniqueness_of :canonical_name

  has_many :projects
end

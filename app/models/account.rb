class Account < ActiveRecord::Base
  attr_protected :id

  belongs_to :chartiy
  belongs_to :project
end

class Account < ActiveRecord::Base
  attr_protected :id

  belongs_to :charity
  belongs_to :project
end

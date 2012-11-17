class Profile < ActiveRecord::Base
  belongs_to :user

  attr_protected :id

  FIELDS = ["real_name", "mobile", "address", "zipcode"]
end

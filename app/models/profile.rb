class Profile < ActiveRecord::Base
  belongs_to :user

  attr_protected :id

  FIELDS = ["address", "zipcode", "mobile", "real_name"]
end

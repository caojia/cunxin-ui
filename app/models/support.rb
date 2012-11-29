class Support < ActiveRecord::Base
  attr_protected :id

  belongs_to :photo
end

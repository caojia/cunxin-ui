class Payment < ActiveRecord::Base
  attr_protected :id

  belongs_to :user
  belongs_to :account
  belongs_to :project

  STATUS_FINISH = "finish"
  STATUS_PENDING = "pending"

end

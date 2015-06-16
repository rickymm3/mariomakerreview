class Reply < ActiveRecord::Base
  validate

  belongs_to :user
  belongs_to :topic

end

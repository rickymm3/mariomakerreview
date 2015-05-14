class Role < ActiveRecord::Base

  has_many :user_roles
  has_many :users, -> { select("roles.*, user_roles.topic_id AS topic_id") }, :through => :user_roles

end

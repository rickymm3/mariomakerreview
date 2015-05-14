class Topic < ActiveRecord::Base
  belongs_to :cliq
  has_many :post
  has_many :topic_report
  belongs_to :user
  has_many :replies
  is_impressionable

end

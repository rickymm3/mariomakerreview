class Topic < ActiveRecord::Base
  extend FriendlyId
  friendly_id :subject, use: :slugged
  belongs_to :cliq
  has_many :post
  has_many :topic_report
  belongs_to :user
  has_many :replies
  is_impressionable :counter_cache => true, :unique => true
end

class Topic < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

  def slug_candidates
    [
        :subject,
        [:subject, :id]
    ]
  end
  belongs_to :cliq
  has_many :post
  has_many :topic_report
  belongs_to :user
  has_many :replies
  is_impressionable :counter_cache => true, :unique => true
end

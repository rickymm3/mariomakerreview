class Topic < ActiveRecord::Base
  extend FriendlyId
  friendly_id :subject, use: [:slugged, :finders]

  belongs_to :cliq
  has_many :post
  has_many :topic_report
  belongs_to :user
  has_many :replies
  is_impressionable :counter_cache => true, :unique => true

  def decay_exp
    Topic.all.each do |t|
      t.update_attributes(exp: decay(t.exp))
    end
  end

  private

  def decay(exp)
    exp = exp - 5
    if exp < 0
      exp = 0
    end
    exp
  end

end

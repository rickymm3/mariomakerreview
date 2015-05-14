class TopicReport < ActiveRecord::Base
  has_one :user
  belongs_to :topic
  attr_accessor :report_reason_id
  validates :report_reason_id, presence: true

end

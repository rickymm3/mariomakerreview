class LCategory < ActiveRecord::Base
  has_and_belongs_to_many :mario_levels
  validates :category, presence: true
  # validate :valid_url
  #
  # def valid_url
  #   unless validates :ss_loc, presence: false
  #
  #   if nominator_id == nominee_id
  #     errors.add(:nominator_id, "can't nominate your self")
  #   end
  # end
end

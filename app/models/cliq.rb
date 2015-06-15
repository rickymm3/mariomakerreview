class Cliq < ActiveRecord::Base
  has_ancestry
  has_many :topic, :foreign_key => 'cliq_id'
  has_many :favorites
  validates_uniqueness_of :name, scope: :ancestry
  extend FriendlyId
  friendly_id :name, use: :slugged

  def self.search(search, current_cliq)
    hash = Hash.new
    hash['results'] = Cliq.similar_search(search)
    hash['match'] = current_cliq.descendants.matching_search(search).first
    # hash['exact'] = Cliq.exact_search(search, current_cliq)
    hash
  end

  def self.similar_search(search)
    if search
      where('cached_name LIKE ?', "%#{search.downcase}%")
    else
      scoped
    end
  end

  def self.matching_search(search)
    if search
      where('cached_name = ?', "#{search.downcase}")
    else
      scoped
    end
  end

  # def self.exact_search(search, current_cliq)
  #   if search
  #     where('cached_name = ?', search.downcase).where(parent_id: current_cliq.id)
  #   end
  # end

  def self.cliq_latest(cliq)
    cliq.descendants.order("updated_at desc").limit(10)
  end
end

class Cliq < ActiveRecord::Base
  has_ancestry
  has_many :topic, :foreign_key => 'cliq_id'
  attr_accessor :search
  def self.search(search, current_cliq)
    hash = Hash.new
    hash['results'] = Cliq.similar_search(search)
    hash['match'] = current_cliq.descendants.matching_search(search).first
    unless hash['match']
      hash['temp'] = Cliq.new(name:search, parent: current_cliq)
    end
    hash
  end

  def self.similar_search(search)
    if search
      where('name LIKE ?', "%#{search.downcase}%")
    else
      scoped
    end
  end

  def self.matching_search(search)
    if search
      where('name = ?', "#{search.downcase}")
    else
      scoped
    end
  end

  def self.cliq_latest(cliq)
    cliq.descendants.order("updated_at desc").limit(10)
  end
end

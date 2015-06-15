class AddDefaultLockedStickyToTopics < ActiveRecord::Migration
  def change
    change_column :topics, :sticky, :boolean, :default => false
    change_column :topics, :locked, :boolean, :default => false
  end
end

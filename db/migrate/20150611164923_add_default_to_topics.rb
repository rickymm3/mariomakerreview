class AddDefaultToTopics < ActiveRecord::Migration
  def change
    def up
      change_column :topics, :sticky, :boolean, :default => false
      change_column :topics, :locked, :boolean, :default => false
    end
  end
end

class AddRemovedToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :active, :boolean, default: true
  end
end

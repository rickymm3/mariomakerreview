class AddOpenedToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :opened, :boolean, default: false
  end
end

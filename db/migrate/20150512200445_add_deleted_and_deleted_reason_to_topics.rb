class AddDeletedAndDeletedReasonToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :remove_reason, :string
    add_column :topics, :reports, :integer
  end
end

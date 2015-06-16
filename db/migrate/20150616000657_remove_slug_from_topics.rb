class RemoveSlugFromTopics < ActiveRecord::Migration
  def change
    remove_column :topics, :slug, :string
  end
end

class AddActiveToFavorites < ActiveRecord::Migration
  def change
    add_column :favorites, :active, :boolean, default: false
  end
end

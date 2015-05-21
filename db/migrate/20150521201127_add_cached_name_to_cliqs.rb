class AddCachedNameToCliqs < ActiveRecord::Migration
  def change
    add_column :cliqs, :cached_name, :string
  end
end

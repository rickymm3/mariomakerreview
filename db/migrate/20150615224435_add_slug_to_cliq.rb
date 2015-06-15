class AddSlugToCliq < ActiveRecord::Migration
  def change
    add_column :cliqs, :slug, :string
    add_index :cliqs, :slug, unique: true
  end
end

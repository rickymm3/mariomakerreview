class RemoveParentIdFromTopics < ActiveRecord::Migration
  def change
    add_column :cliqs, :cliq_p_id, :integer
  end
end

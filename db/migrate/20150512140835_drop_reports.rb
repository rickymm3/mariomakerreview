class DropReports < ActiveRecord::Migration
  def up
    drop_table :reports
  end

  def down
    create_table :reports
  end
end

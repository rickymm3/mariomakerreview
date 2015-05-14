class CreateTopicReports < ActiveRecord::Migration
  def change
    create_table :topic_reports do |t|
      t.integer :topic_id
      t.integer :user_id
      t.string :user_comment
      t.integer :report_reason_id
      t.timestamps
    end
  end
end

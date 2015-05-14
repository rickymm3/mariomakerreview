class CreateReplyReports < ActiveRecord::Migration
  def change
    create_table :reply_reports do |t|
      t.integer :reply_id
      t.string :user_comment
      t.integer :user_id
      t.integer :report_reason_id
      t.timestamps
    end
  end
end

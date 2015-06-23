class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.integer :user_id
      t.integer :topic_id
      t.boolean :done, default: false
    end
  end
end

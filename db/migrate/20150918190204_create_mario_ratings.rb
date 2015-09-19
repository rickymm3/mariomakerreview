class CreateMarioRatings < ActiveRecord::Migration
  def change
    create_table :mario_ratings do |t|
      t.integer :fun
      t.integer :puzzle
      t.integer :difficulty
      t.integer :overall
      t.integer :user_id
      t.integer :mario_level_id
      t.timestamps null: false
    end
  end
end

class CreateMarioLevels < ActiveRecord::Migration
  def change
    create_table :mario_levels do |t|
      t.string :name
      t.integer :user_id
      t.string :description
      t.string :ss_loc
      t.integer :fun_rank
      t.integer :puzzle_rank
      t.integer :difficulty_rank
      t.integer :overall_rank
      t.integer :close_vote
      t.integer :l_category_id
      t.string :level_code
      t.boolean :disabled, default: false

      t.timestamps null: false
    end
  end
end

class CreateLCategories < ActiveRecord::Migration
  def change
    create_table :l_categories do |t|
      t.string :category

      t.timestamps null: false
    end
  end
end

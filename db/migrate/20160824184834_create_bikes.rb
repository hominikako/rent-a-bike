class CreateBikes < ActiveRecord::Migration
  def change
    drop_table :bikes
    create_table :bikes do |t|
      t.string :name
      t.integer :category
      t.boolean :available
      t.integer :status
      t.string :colour
      t.string :comment
      t.string :image

      t.timestamps null: false
    end
  end
end

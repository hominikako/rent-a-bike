class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.integer :type
      t.boolean :available
      t.integer :status
      t.string :colour
      t.string :comment
      t.string :image

      t.timestamps null: false
    end
  end
end
